// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "lib/openzeppelin-contracts/contracts/utils/Counters.sol";

contract Spacebook is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    mapping (uint256 => string) private __names;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Spacebook", "SPBK") {}

    function safeMint(address to, string memory name, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        __names[tokenId] = name;
        _setTokenURI(tokenId, uri);
    }
    
    function planetName(uint256 tokenId) public view returns (string memory) {
        return __names[tokenId];
    }

    function setURI(uint256 id, string memory uri) public onlyOwner {
        super._setTokenURI(id, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
