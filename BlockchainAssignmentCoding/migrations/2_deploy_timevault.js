const TimeVault = artifacts.require("TimeVault");

module.exports = function (deployer) {
  deployer.deploy(TimeVault, 2); // assuming requiredApprovals is set to 2
};
