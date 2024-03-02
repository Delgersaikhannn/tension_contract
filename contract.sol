// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Tension is ERC721, ERC721Burnable, Ownable {
    using SafeMath for uint256;

    event TokenMinted(address indexed owner, uint256 indexed tokenId);

    uint256 public mintPrice = 0.15 ether;
    string tokenName = "TENSION";
    string tokenSymbol = "TSN";
    string baseURI =
        "https://bafybeihrutv46c2qcd4v63lu6vqzpu66kzulivtl7umorlwb53voost324.ipfs.nftstorage.link/";

    constructor() ERC721(tokenName, tokenSymbol) Ownable(msg.sender) {}

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function safeMint(address to, uint256 tokenId) public payable {
        require(msg.value == mintPrice, "Incorrect Ether amount sent");

        _safeMint(to, tokenId);
        emit TokenMinted(to, tokenId);
    }

    function setMintPrice(uint256 newPrice) external onlyOwner {
        mintPrice = newPrice;
    }

    function collectEther() external onlyOwner {
        address payable ownerAddress = payable(owner());
        ownerAddress.transfer(address(this).balance);
    }

    function transferOwnership(address newOwner) public override onlyOwner {
        require(newOwner != address(0), "New owner cannot be the zero address");
        _transferOwnership(newOwner);
    }
}
