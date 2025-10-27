// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.30;

contract SampleFallback {
    uint public lastValueSent;
    string public lastFuntionCalled;

    receive() external payable {
        lastValueSent = msg.value;
        lastFuntionCalled = "receive";
    }

    fallback() external payable {
        lastValueSent = msg.value;
        lastFuntionCalled = "fallback";
     }
}
