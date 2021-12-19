// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

//import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
/**
 * @title SmartWill
 * @dev Time based resource transfers
 */
contract Colors is ERC721Enumerable {

    event TokenMinted(string _rgb, uint id);
    
    string[] public mintedColors;
    mapping(string => bool) _colorMinted;

    constructor() ERC721("Colors", "CLR") {}

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721Enumerable){
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721Enumerable) returns (bool){
        return super.supportsInterface(interfaceId);
    }

    /**
        Creates a new Color token
    */
    function mint(string memory _rgb) public {
        require(validateRgb(_rgb) == true, 'Wrong color format');
        require(_colorMinted[_rgb] == false, 'A token for this color is already minted');
        mintedColors.push(_rgb);
        uint _id = mintedColors.length - 1;
        _mint(msg.sender, _id);
        _colorMinted[_rgb] = true;
        emit TokenMinted(_rgb,_id);
    }

    /**
        Assures string is in correct RGB format
    */
    function validateRgb(string memory str) internal pure returns (bool){
        bytes memory b = bytes(str);
        if(b.length != 6) return false;
        for(uint i; i<b.length; i++){
            bytes1 char = b[i];
            if(
                !(char >= 0x30 && char <= 0x39) && //9-0
                !(char >= 0x41 && char <= 0x46) && //A-F
                !(char >= 0x61 && char <= 0x66)
            )
            return false;
        }
        return true;
    }

   
   
}