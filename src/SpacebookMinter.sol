// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol";

import "./Spacebook.sol";

contract SpacebookMinter is Ownable {
    address public __nft;
    address public __receipient;
    uint256 public __num_names;
    mapping (uint256 => string) __names;
    uint256 public __num_uris;
    mapping (uint256 => string) __uris;
    bool private __frozen;

    constructor(address receipient) {
        require(receipient != address(0),
            "Spacebook Minter: Receipient address cannot be null"
        );

        Spacebook spacebook = new Spacebook();

        __nft = address(spacebook);
        __receipient = receipient;
    }

    function addPlanet(
        string memory name,
        string memory uri
    ) public onlyOwner thawed {
        __addName(name);
        __addURI(uri);
        require(__num_names == __num_uris,
            "Spacebook Minter: Arrays misaligned");
    }

    function __addName(string memory name) internal onlyOwner thawed {
        __names[__num_names] = name;
        __num_names += 1;
    }

    function __addURI(string memory uri) internal onlyOwner thawed {
        __uris[__num_uris] = uri;
        __num_uris += 1;
    }

    function mint() public thawed {
        require(__num_names == __num_uris ,
            "Spacebook Minter: Arrays misaligned");
        Spacebook token = Spacebook(__nft);
        uint256 n = __num_uris;

        for (uint256 i=0;i<n;i++) {
            string memory curr_name = __names[i];
            string memory curr_uri = __uris[i];
            token.safeMint(__receipient, curr_name, curr_uri);
        }

        __frozen = true;
    }

    modifier thawed() {
        require(!__frozen, "Spacebook Minter: Frozen");
        _;
    }
}

