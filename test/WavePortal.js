const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Wave Portal", () => {
  let MyConsole, myConsole

  beforeEach(async () => {
    MyConsole = await ethers.getContractFactory("WavePortal");
    myConsole = await MyConsole.deploy();
  })

  describe('Total Waves', () => {
    it("should return total waves", async () => {
    await myConsole.deployed();
    expect(await myConsole.getTotalWaves()).to.equal(0);
    });
  })

  describe('Add Wave Count', () => {
    it("should add 1 wave", async () => {
    await myConsole.wave();
    expect(await myConsole.getTotalWaves()).to.equal(1);
    });
  })
});     