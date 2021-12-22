// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "ds-test/test.sol";

import "./SpacebookMinter.sol";

contract SpacebookMinterTest is DSTest {
    SpacebookMinter minter;

    function setUp() public {
        /* arbitrary */
        address receipient = address(0xb64fFF912DF2B9e6672Bc33407175fE8Fae968c6);

        minter = new SpacebookMinter(receipient);
    }

    function test_addPlanet_success() public {
        string memory name = "Planet Claire!";
        string memory uri = "cafebeef";
        minter.addPlanet(name, uri);
    }

    function testFail_addPlanet_frozen_failure() public {
        string memory name = "Planet Claire!";
        string memory uri = "cafebeef";
        minter.addPlanet(name, uri);

        minter.mint();

        minter.addPlanet(name, uri);
    }

    function test_mint_success() public {
        string memory name = "Planet Claire!";
        string memory uri = "cafebeef";
        minter.addPlanet(name, uri);

        minter.mint();
    }

    function test_mint_e2e_success() public {
        string[25] memory names = [
            "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
            "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y"
        ];
        string[25] memory uris = [
            "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
            "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y"
        ];

        for(uint256 i=0;i<uris.length;i++) {
            string memory curr_name = names[i];
            string memory curr_uri = uris[i];
            minter.addPlanet(curr_name, curr_uri);
        }

        minter.mint();

        Spacebook spacebook = Spacebook(minter.__nft());

        assertEq(spacebook.balanceOf(minter.__receipient()), uris.length);
    }
}
