const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("VintageJerseyNFT", function () {
  this.timeout(50000);

  let jerseyNFT;
  let owner;
  let acc1;
  // let acc2;
  const price = ethers.utils.parseUnits("1");

  this.beforeEach(async function () {
    // This is executed before each test
    // Deploying the smart contract
    const VintageJerseyNFT = await ethers.getContractFactory("VintageJerseyNFT");
    [owner, acc1] = await ethers.getSigners();

    jerseyNFT = await VintageJerseyNFT.deploy();
  });

  it("Should set the right owner", async function () {
    expect(await jerseyNFT.owner()).to.equal(owner.address);
  });

  it("Should mint one NFT", async function () {
    expect(await jerseyNFT.balanceOf(acc1.address)).to.equal(0);

    const tokenURI = "https://example.com/1";
    const tx = await jerseyNFT.connect(acc1).uploadJersey(tokenURI,price);
    await tx.wait();

    expect(await jerseyNFT.balanceOf(acc1.address)).to.equal(1);
  });

  it("Should set the correct tokenURI", async function () {
    const tokenURI_1 = "https://example.com/1";
    const tokenURI_2 = "https://example.com/2";

    const tx1 = await jerseyNFT.connect(owner).uploadJersey(tokenURI_1,price);
    await tx1.wait();
    const tx2 = await jerseyNFT.connect(owner).uploadJersey(tokenURI_2,price);
    await tx2.wait();

    expect(await jerseyNFT.tokenURI(0)).to.equal(tokenURI_1);
    expect(await jerseyNFT.tokenURI(1)).to.equal(tokenURI_2);
  });
});
