// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC721, ERC721Burnable, Ownable {
    event TokenMinted(address indexed owner, uint256 indexed tokenId);

    constructor() ERC721("TENSION", "TSN") {}

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://bafybeihrutv46c2qcd4v63lu6vqzpu66kzulivtl7umorlwb53voost324.ipfs.nftstorage.link/";
    }

    function safeMint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
        emit TokenMinted(to, tokenId);
    }
}
