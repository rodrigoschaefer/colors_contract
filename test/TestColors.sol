// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Colors.sol";

contract TestColors {

    // Truffle will send the TestContract one Ether after deploying the contract.
    uint public initialBalance = 1 ether;

    Colors colors = Colors(DeployedAddresses.Colors());

    address payable expectedOwner = payable(address(this));
    
    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
    
    function beforeAll () public {}

    function testMint() public {
        colors.mint('112233');
        uint supply = colors.totalSupply();
        Assert.equal(supply, 1, "Total supply should be 1");
    }

    function testMintFail() public {
        string memory errorMsg;
        try  colors.mint('112233') {
        } catch Error(string memory reason) {
            errorMsg = reason;
        }
        Assert.equal(errorMsg,'A token for this color is already minted', 'A token for a color should not be minted more than once');
    }

}

