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

    function test_addURI_success() public {
        string memory uri = "cafebeef";
        minter.addURI(uri);
    }

    function testFail_addURI_frozen_failure() public {
        string memory uri = "cafebeef";
        minter.addURI(uri);

        minter.mint();

        minter.addURI(uri);
    }

    function test_mint_success() public {
        string memory uri = "cafebeef";
        minter.addURI(uri);

        minter.mint();
    }
}
