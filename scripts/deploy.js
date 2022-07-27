const hre = require("hardhat");

async function main() {
  const VintageJerseyNFT = await hre.ethers.getContractFactory("VintageJerseyNFT");
  const vintageJerseyNFT = await VintageJerseyNFT.deploy();

  await vintageJerseyNFT.deployed();

  console.log("VintageJerseyNFT deployed to:", vintageJerseyNFT.address);
  storeContractData(vintageJerseyNFT)
}

function storeContractData(contract) {
  const fs = require("fs");
  const contractsDir = __dirname + "/../src/contracts";

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    contractsDir + "/VintageJerseyNFT-address.json",
    JSON.stringify({ VintageJerseyNFT: contract.address }, undefined, 2)
  );

  const VintageJerseyNFTArtifact = artifacts.readArtifactSync("VintageJerseyNFT");

  fs.writeFileSync(
    contractsDir + "/VintageJerseyNFT.json",
    JSON.stringify(VintageJerseyNFTArtifact, null, 2)
  );
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
