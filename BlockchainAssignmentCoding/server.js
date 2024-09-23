const express = require("express");
const path = require("path");
const Web3 = require('web3').default;
const fs = require("fs");
const app = express();

// Load the ABI and networks of your contract from JSON
const contractJSON = JSON.parse(fs.readFileSync(path.join(__dirname, "/build/contracts/TimeVault.json"), "utf-8"));

// Initialize Web3 using Ganache's local provider (http://127.0.0.1:7545)
const web3 = new Web3("http://127.0.0.1:7545");

// Get the network ID from Web3 (Ganache usually uses network ID 5777)
async function getNetworkId() {
    return await web3.eth.net.getId();  // Typically, Ganache uses network ID 5777
}

// Serve the 'build' directory as a static directory
app.use(express.static(path.join(__dirname, "build")));

app.post("/signin", async (req, res) => {
    // Handle your sign-in logic here
    res.json({ success: true, message: "Signed in successfully" });
});

// Serve the index.html file
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "/index.html"));
});

// API to dynamically check if a given address is the contract owner (admin)
app.get("/check-admin/:address", async (req, res) => {
    try {
        const userAddress = req.params.address.toLowerCase(); // Address from request

        // Dynamically get network ID and contract address
        const networkId = await getNetworkId();
        const deployedNetwork = contractJSON.networks[networkId]; // Get the contract details for the current network
        if (!deployedNetwork) {
            return res.status(400).json({ success: false, message: "Contract not deployed on this network" });
        }

        // Get the contract address from the network information
        const contractAddress = deployedNetwork.address;

        // Initialize the contract using the ABI and dynamic contract address
        const contract = new web3.eth.Contract(contractJSON.abi, contractAddress);

        // Fetch the contract owner dynamically from the blockchain
        const ownerAddress = await contract.methods.owner().call();

        // Check if the user address matches the owner address
        const isAdmin = (userAddress === ownerAddress.toLowerCase());

        res.json({ success: true, isAdmin, owner: ownerAddress });
    } catch (error) {
        console.error("Error checking admin status:", error);
        res.status(500).json({ success: false, message: "Error checking admin status" });
    }
});



const server = app.listen(5000, () => {
    const portNumber = server.address().port;
    console.log(`Server is running on http://localhost:${portNumber}`);
});
