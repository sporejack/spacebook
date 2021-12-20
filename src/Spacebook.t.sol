pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./Spacebook.sol";

contract SpacebookTest is DSTest {
    Spacebook spacebook;

    function setUp() public {
        spacebook = new Spacebook();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
