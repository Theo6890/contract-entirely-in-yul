import { expect } from 'chai';
import { ethers } from 'hardhat';

describe('MinimalVault', function () {
    /*//////////////////////////////////////////////////////////////
                                 BASIC ATTRIBUTES
    //////////////////////////////////////////////////////////////*/
    it('Should return name MinimalVault', async function () {
        const MinimalVault = await ethers.getContractFactory('MinimalVault');
        const minimalvault = await MinimalVault.deploy();
        await minimalvault.deployed();

        expect(await minimalvault.name()).to.equal('MinimalVault');
    });
});
