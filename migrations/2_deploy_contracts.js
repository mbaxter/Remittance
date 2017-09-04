const Remittance = artifacts.require("./Remittance.sol");

// todo - debug deployment
module.exports = function(deployer, network, accounts) {
	if (accounts.length < 2) {
		throw new Error("At least 2 available accounts must be available in order to deploy");
	}
	deployer.deploy(Remittance, accounts[1], "0xf2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2", 10);
};
