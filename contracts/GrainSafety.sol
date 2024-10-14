// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract GrainSafety {
    struct GrainBatch {
        uint256 batchId;
        string grainType;
        uint256 weight;
        uint256 temperature;
        uint256 humidity;
        address farmer;
        bool safetyCompliance;
    }

    mapping(uint256 => GrainBatch) public grainBatches;
    uint256 public nextBatchId;

    event NewBatchAdded(uint256 batchId, address farmer);
    event ComplianceUpdated(uint256 batchId, bool safetyCompliance);

    function addGrainBatch(string memory grainType, uint256 weight, uint256 temperature, uint256 humidity) public {
        require(temperature > 0 && humidity > 0, "Invalid sensor data");
        bool compliance = checkSafetyCompliance(temperature, humidity);
        grainBatches[nextBatchId] = GrainBatch(nextBatchId, grainType, weight, temperature, humidity, msg.sender, compliance);
        emit NewBatchAdded(nextBatchId, msg.sender);
        nextBatchId++;
    }

    function checkSafetyCompliance(uint256 temperature, uint256 humidity) internal pure returns (bool) {
        return (temperature < 30 && humidity < 50);
    }

    function updateCompliance(uint256 batchId, uint256 newTemperature, uint256 newHumidity) public {
        require(batchId < nextBatchId, "Batch does not exist");
        bool newCompliance = checkSafetyCompliance(newTemperature, newHumidity);
        grainBatches[batchId].temperature = newTemperature;
        grainBatches[batchId].humidity = newHumidity;
        grainBatches[batchId].safetyCompliance = newCompliance;
        emit ComplianceUpdated(batchId, newCompliance);
    }

    function getBatchDetails(uint256 batchId) public view returns (GrainBatch memory) {
        require(batchId < nextBatchId, "Batch does not exist");
        return grainBatches[batchId];
    }
}
