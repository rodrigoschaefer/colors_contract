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

    uint256 currentId = 0;
    mapping(string => uint256) public _colors;

    constructor() ERC721("Colors", "CLR") {}

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721Enumerable){
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721Enumerable) returns (bool){
        return super.supportsInterface(interfaceId);
    }

    function mint(string memory _rgb) public {
        currentId++;
        // Colors should not have been used yet
        require(_colors[_rgb] == 0, 'A token for this color is already minted');
        _colors[_rgb] = currentId;
        _mint(msg.sender, currentId);
        emit TokenMinted(_rgb,currentId);
    }

}