const {Web3} = require('web3');
const GrainSafety = require('./../frontend/src/contracts/GrainSafety.json');

const web3 = new Web3('http://localhost:7545');
const contractAddress = '0xB37AbA199226BEd68F63632fA266aFBAE27fa784'; // Replace with your deployed contract address
const account = '0xC458B76a1A9D9914dee0cD120a521010C40E4222'; // Replace with your account address
const contract = new web3.eth.Contract(GrainSafety.abi, contractAddress);

async function addGrainBatch(grainType, weight, temperature, humidity) {
    const receipt = await contract.methods.addGrainBatch(grainType, weight, temperature, humidity).send({ from: account });
    console.log('New Batch Added: ', receipt.events.NewBatchAdded.returnValues);
}

async function updateCompliance(batchId, newTemperature, newHumidity) {
    const receipt = await contract.methods.updateCompliance(batchId, newTemperature, newHumidity).send({ from: account });
    console.log('Compliance Updated: ', receipt.events.ComplianceUpdated.returnValues);
}

module.exports = { addGrainBatch, updateCompliance };