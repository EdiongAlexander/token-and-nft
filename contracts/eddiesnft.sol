// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract EddiesNFTClub is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
     uint256 public mintRate = 0.02 ether;



    constructor() ERC721("EddiesNFT Club", "ENC") {

    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/QmT2nXVVid94KkLQUAL8RwMSuBbAg2BfUJL1DeMLYnBK2j";
    }

    function safeMint(address to) public payable {
        require(msg.value >= mintRate, "Not enough ether sent");
        _tokenIdCounter.increment();
        _safeMint(to, _tokenIdCounter.current());
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    function withdraw() public onlyOwner {
        require(address(this).balance > 0, "Balance is 0");
        payable(owner()).transfer(address(this).balance);
    }
}
