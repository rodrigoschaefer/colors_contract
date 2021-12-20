// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Colors.sol";

contract TestColors {

    event TokenObetained(uint id);

    // Truffle will send the TestContract one Ether after deploying the contract.
    uint public initialBalance = 1 ether;

    Colors colorsContract = Colors(DeployedAddresses.Colors());
    
    address payable expectedOwner = payable(address(this));
    
    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
    
    function beforeAll () public {}

    function testMint() public {
        colorsContract.mint('112233');
        uint supply = colorsContract.totalSupply();
        Assert.equal(supply, 1, "Total supply should be 1");
        string memory colorId = colorsContract.mintedColors(0);
        Assert.equal(colorId, '112233', "Color id should be '112233'");
    }

    function testMintFailDuplicateColor() public {
        string memory errorMsg;
        try  colorsContract.mint('112233') {
        } catch Error(string memory reason) {
            errorMsg = reason;
        }
        Assert.equal(errorMsg,'A token for this color is already minted', 'A token for a color should not be minted more than once');
    }
    
    function testMintFailWrongRgbFormat() public {
        string memory errorMsg;
        try  colorsContract.mint('11223P') {
        } catch Error(string memory reason) {
            errorMsg = reason;
        }
        Assert.equal(errorMsg,'Wrong color format', 'Color format should be 6 hex chars');
    } 

     function testGetTokenByOwner() public {
        colorsContract.mint('445566');
        colorsContract.mint('778899');
        colorsContract.mint('001122');
        uint balance = colorsContract.balanceOf(expectedOwner);
        Assert.equal(balance, 4, "Owned token count should be 4");
        for(uint i=0;i<balance;i++){
            uint tokenId = colorsContract.tokenOfOwnerByIndex(expectedOwner,i);
            emit TokenObetained(tokenId);
        }
    }   
}

