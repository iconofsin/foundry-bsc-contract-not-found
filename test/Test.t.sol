// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import "forge-std/Test.sol";
import "forge-std/StdUtils.sol";

interface IERC20 {
    function approve(address spender, uint256 amount) external returns (bool);
}

interface IMockIssue {
    function issue(uint256 wad) external;
}

contract BSCTest is Test {
    uint256 bscFork;
     uint256 arbFork;
     uint256 ethFork;

    address private constant B_WBNB =
        0x8a9043dA48F2eC50a35CeF0ec26932E61dB1b2A3;

    function setUp() public {  
        arbFork = vm.createFork(vm.envString("ARBITRUM_GOERLI_RPC"), 23355525);
        bscFork = vm.createFork(vm.envString("BSC_TESTNET_RPC"), 30306509);
        ethFork = vm.createFork(vm.envString("ETHEREUM_SEPOLIA_RPC"), 3601652);
    }

    function test_bsc_approval() public {
          vm.selectFork(bscFork);
        address account = vm.addr(1);

        deal(B_WBNB, account, 1);

        vm.prank(account);
        IERC20(B_WBNB).approve(address(this), 1);
    }

    function test_bsc_issue() public {
          vm.selectFork(bscFork);
        address account = vm.addr(2);

        vm.prank(account);
        IMockIssue(B_WBNB).issue(1);
    }
}
