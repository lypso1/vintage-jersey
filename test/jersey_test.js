const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Counters", function () {
  this.timeout(50000);

  let counter;

  this.beforeEach(async function () {
    const VintageJerseyNFT = await ethers.getContractFactory("VintageJerseyNFT");
    counter = await VintageJerseyNFT.deploy();
  });

  it("Should get count", async function () {
    expect(await counter.get()).to.equal(0);
  });

  it("Should increment count", async function () {
    const tx = await counter.inc();
    await tx.wait();

    expect(await counter.get()).to.equal(1);
  });

  it("Should decrement count", async function () {
    const incTx = await counter.inc();
    await incTx.wait();

    const decTx = await counter.dec();
    await decTx.wait();

    expect(await counter.get()).to.equal(0);
  });
});
