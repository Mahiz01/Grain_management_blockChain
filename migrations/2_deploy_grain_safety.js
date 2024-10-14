const GrainSafety = artifacts.require("GrainSafety");

module.exports = function (deployer) {
    deployer.deploy(GrainSafety);
};
