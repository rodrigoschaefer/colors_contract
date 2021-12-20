const colorsContract = artifacts.require("Colors");
const truffleAssert = require('truffle-assertions');
 
contract('Colors', (accounts) => {

  it("should mint the token", async ()=> {
    const instance = await colorsContract.deployed();
    await instance.mint('112233');
    var supply = await instance.totalSupply();
    assert.equal(supply, 1, "Total supply should be 1");
    var colorId = await instance.mintedColors(0);
    assert.equal(colorId, '112233', "Color id should be '112233'");
  });

  it("should get the token ids", async ()=> {
    const instance = await colorsContract.deployed();
    await instance.mint('445566');
    await instance.mint('000001',{from: accounts[1]});
    await instance.mint('778899');
    var balance = await instance.balanceOf(accounts[0]);
    assert.equal(balance, 3, "Owned token count should be 3");
    for(var i=0;i<balance;i++){
        var tokenId = await instance.tokenOfOwnerByIndex(accounts[0],i);
        console.log(tokenId);
    }
  });

});