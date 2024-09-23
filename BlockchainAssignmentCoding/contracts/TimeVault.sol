// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimeVault {
    enum DocumentStatus { Queued, Locked, Unlocked, Cancelled }

    struct Document {
        string ipfsHash;
        string name;
        uint unlockTime;
        address[] recipients;
        DocumentStatus status;
        address documentOwner;
        uint transactionTime;
        uint approvalCount;
        uint statusChangeTime;  // Add this field
        address rejectedBy;  // New field to store who rejected the document
    }

    mapping(uint => Document) public documents;
    mapping(address => uint[]) public userDocuments;
    mapping(address => bool) public isAdmin;
    mapping(uint => mapping(address => bool)) public approvals;
    address[] public adminList;  // Store all admin addresses
    uint public documentCount;
    uint public requiredApprovals;
    address public owner;
    bool public paused = false;

    event DocumentLocked(uint documentId, string ipfsHash, uint unlockTime,string name);
    event DocumentExtended(uint documentId, uint newUnlockTime);
    event DocumentUnlocked(uint documentId);
    event FundsWithdrawn(address to, uint amount);
    event DocumentRecipientsUpdated(uint documentId, address[] newRecipients);
    event DocumentCancelled(uint documentId);
    event DocumentQueued(uint documentId);
    event DocumentExecuted(uint documentId);
    event DocumentApproved(uint documentId, address approver);
    event DocumentRejected(uint documentId, address rejectedBy);
    event AdminAssigned(address admin);
    event AdminRevoked(address admin);

    constructor(uint _requiredApprovals) {
        owner = msg.sender;
        requiredApprovals = _requiredApprovals;
        isAdmin[msg.sender] = true;
        adminList.push(msg.sender); // Add owner as the first admin
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    modifier onlyAdmin() {
        require(isAdmin[msg.sender], "Only an admin can perform this action");
        _;
    }

    modifier onlyRecipientOrOwner(uint documentId) {
        Document memory doc = documents[documentId];
        bool isRecipient = false;
        for (uint i = 0; i < doc.recipients.length; i++) {
            if (doc.recipients[i] == msg.sender) {
                isRecipient = true;
                break;
            }
        }
        require(isRecipient || msg.sender == owner, "Not authorized");
        _;
    }

    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    function lockDocument(
        string memory ipfsHash,
        uint timeLock,
        address[] memory recipients,
        string memory name //Accept the document name 
    ) public whenNotPaused {
        require(timeLock > block.timestamp, "TimeLock must be in the future");
        require(recipients.length > 0, "Recipients list cannot be empty");

        documentCount++;
        Document storage newDoc = documents[documentCount];
        newDoc.ipfsHash = ipfsHash;
        newDoc.unlockTime = timeLock;
        newDoc.recipients = recipients;
        newDoc.status = DocumentStatus.Queued;
        newDoc.documentOwner = msg.sender;
        newDoc.transactionTime = block.timestamp;
        newDoc.approvalCount = 0;
         newDoc.name = name; // Set document name

        emit DocumentLocked(documentCount, ipfsHash, timeLock,name);
        emit DocumentQueued(documentCount);

        for (uint i = 0; i < recipients.length; i++) {
            userDocuments[recipients[i]].push(documentCount);
        }

        userDocuments[msg.sender].push(documentCount);
    }

    function approveDocument(uint documentId) public onlyAdmin whenNotPaused {
        Document storage doc = documents[documentId];
        require(doc.status == DocumentStatus.Queued, "Document is not in a queued state");
        require(!approvals[documentId][msg.sender], "Admin has already approved this document");

        approvals[documentId][msg.sender] = true;
        doc.approvalCount++;
        emit DocumentApproved(documentId, msg.sender);

        if (doc.approvalCount >= requiredApprovals) {
            executeDocument(documentId);
        }
    }

    function rejectDocument(uint documentId) public onlyAdmin whenNotPaused {
    Document storage doc = documents[documentId];
    require(doc.status == DocumentStatus.Queued, "Only queued documents can be rejected");

    // Change the document status to Cancelled
    doc.status = DocumentStatus.Cancelled;
    doc.statusChangeTime = block.timestamp; // Update the status change time
    doc.rejectedBy = msg.sender; // Store who rejected the document

    // Emit an event for rejection
    emit DocumentRejected(documentId, msg.sender);
}



    function executeDocument(uint documentId) internal {
        Document storage doc = documents[documentId];
        require(doc.status == DocumentStatus.Queued, "Document is not in a queued state");
        require(doc.approvalCount >= requiredApprovals, "Not enough approvals");

        doc.status = DocumentStatus.Locked;
        doc.statusChangeTime = block.timestamp;  // Update status change time
        emit DocumentExecuted(documentId);
    }

    function getDocumentStatus(uint documentId) public view returns (DocumentStatus) {
        return documents[documentId].status;
    }

    function unlockDocument(uint documentId) public whenNotPaused returns (string memory) {
        Document storage doc = documents[documentId];
        require(block.timestamp >= doc.unlockTime, "Document is still locked");
        require(doc.status == DocumentStatus.Locked, "Document is not in a locked state");

        bool isRecipient = false;
        for (uint i = 0; i < doc.recipients.length; i++) {
            if (doc.recipients[i] == msg.sender) {
                isRecipient = true;
                break;
            }
        }
        require(isRecipient, "You are not authorized to access this document");

        doc.status = DocumentStatus.Unlocked;
        emit DocumentUnlocked(documentId);

        return doc.ipfsHash;
    }

    function cancelDocument(uint documentId) public whenNotPaused onlyRecipientOrOwner(documentId) {
        Document storage doc = documents[documentId];
        require(block.timestamp < doc.unlockTime, "Document is already unlocked or time has passed");
        require(doc.status == DocumentStatus.Queued || doc.status == DocumentStatus.Locked, "Cannot cancel this document");

        doc.status = DocumentStatus.Cancelled;
        emit DocumentCancelled(documentId);
    }

    function modifyTimeLock(uint documentId, uint newTimeLock) public whenNotPaused onlyRecipientOrOwner(documentId) {
        require(newTimeLock > block.timestamp, "New TimeLock must be in the future");
        Document storage doc = documents[documentId];
        require(doc.status == DocumentStatus.Queued || doc.status == DocumentStatus.Locked, "Cannot modify a cancelled or unlocked document");
        doc.unlockTime = newTimeLock;
        emit DocumentExtended(documentId, newTimeLock);
    }

    function pauseContract() public onlyOwner {
        paused = true;
    }

    function unpauseContract() public onlyOwner {
        paused = false;
    }

    function assignAdmin(address _admin) public onlyOwner {
        require(!isAdmin[_admin], "Already an admin");
        isAdmin[_admin] = true;
        adminList.push(_admin); // Add the new admin to the list
        emit AdminAssigned(_admin);
    }

    function revokeAdmin(address _admin) public onlyOwner {
        require(isAdmin[_admin], "Not an admin");
        require(_admin != owner, "Cannot revoke the owner's admin rights"); // Prevent revoking the owner
        isAdmin[_admin] = false;

        // Remove admin from adminList
        for (uint i = 0; i < adminList.length; i++) {
            if (adminList[i] == _admin) {
                adminList[i] = adminList[adminList.length - 1]; // Replace with the last element
                adminList.pop(); // Remove the last element
                break;
            }
        }
        emit AdminRevoked(_admin);
    }

    function getAdminCount() public view returns (uint) {
        return adminList.length;
    }

    function getAdminByIndex(uint index) public view returns (address) {
        require(index < adminList.length, "Index out of bounds");
        return adminList[index];
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function withdrawFunds(uint amount) public onlyAdmin whenNotPaused {
        require(address(this).balance >= amount, "Insufficient balance");
        payable(msg.sender).transfer(amount);
        emit FundsWithdrawn(msg.sender, amount);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function monitorActivity() public view returns (uint) {
        return documentCount;
    }

    function getDocument(uint documentId) public view returns (
        string memory ipfsHash,
        uint unlockTime,
        address[] memory recipients,
        DocumentStatus status,
        uint approvalCount,
        string memory name  // Return the name
    ) {
        Document storage doc = documents[documentId];
        return (doc.ipfsHash, doc.unlockTime, doc.recipients, doc.status, doc.approvalCount, doc.name);  // Return the name
    }

    function getDocumentCount() public view returns (uint) {
        return documentCount;
    }

    function getUserDocuments(address user) public view returns (uint[] memory) {
        return userDocuments[user];
    }

    function getTransactionTime(uint documentId) public view returns (uint) {
    return documents[documentId].transactionTime;
}

 // Add the new function to get document name
    function getDocumentName(uint256 documentId) public view returns (string memory) {
        return documents[documentId].name;
    }

function getStatusChangeTime(uint documentId) public view returns (uint) {
    return documents[documentId].statusChangeTime;
}

function getDocumentRejector(uint documentId) public view returns (address) {
    return documents[documentId].rejectedBy;
}


    receive() external payable {}
}
