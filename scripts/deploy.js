
const hre = require("hardhat");

async function main() {
  const ideaPortal = await hre.ethers.getContractFactory("IdeaPortal");
  const ideaPortalContract = await ideaPortal.deploy();

  await ideaPortalContract.deployed();

  console.log("Greeter deployed to:", ideaPortalContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
