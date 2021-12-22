// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "ds-test/test.sol";

import "./Spacebook.sol";

contract SpacebookTest is DSTest {
    Spacebook spacebook;

    function setUp() public {
        spacebook = new Spacebook();
    }

    function test_safeMint_basic_success() public {
        /* arbitrary */
        address receipient = address(0x15f08f623D462D48aBeb6425A867DC6e54722781);
        string memory name = "Planet Claire!";
        string memory uri = "foobar";
        uint256 id = 0;

        spacebook.safeMint(receipient, name, uri);

        assertEq(spacebook.planetName(id), name);
        assertEq(spacebook.tokenURI(id), uri);
    }

    function test_setURI_basic_success() public {
        /* arbitrary */
        address receipient = address(0x15f08f623D462D48aBeb6425A867DC6e54722781);
        string memory name = "Planet Claire!";
        string memory uri = "foobar";
        uint256 id = 0;
        string memory new_uri = "cafebeef";

        spacebook.safeMint(receipient, name, uri);

        spacebook.setURI(id, new_uri);

        assertEq(spacebook.tokenURI(id), new_uri);
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
