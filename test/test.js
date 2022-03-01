const path = require('path');
require('dotenv').config({path: path.resolve(__dirname, '../.env') });

const { expect } = require('chai');
const reasoner = require('eth-revert-reason');

const config = require('../.config.js');

let signers;
let token;

describe("Staking Tests", () => {

  beforeEach(async () => {
    signers = await ethers.getSigners();

    const Token = await ethers.getContractFactory("Token");
    
    token = await Token.deploy("Staking Token", "STEAK");

  });

  it("staking", async () => {

    var staker = signers[0].address;

    var balance = await token.balanceOf(staker);

    var stakeAmount = ethers.utils.parseUnits("100", 18);
    
    var stakeID = await token.stake(stakeAmount, {from: staker} );

    var balanceAfter = await token.balanceOf(staker);
    
    expect(balanceAfter).to.equal(balance.sub(stakeAmount));
  });

  it("cannot stake more than owning", async () => {

    var staker = signers[1].address;

    var stakeAmount = ethers.utils.parseUnits("100", 18);
    
    var attempt = token.stake(stakeAmount, {from: staker});

    await expect(attempt).to.be.reverted;
  });
  


});
