// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;

import '../interfaces/IQuoterV2.sol';
import '@uniswap/v3-core/contracts/libraries/SafeCast.sol';

contract MockQuoterV2 is IQuoterV2 {
    using SafeCast for uint256;

    // Mock price that can be set for testing
    uint160 public mockSqrtPriceX96;
    // Mock amount out that will be returned
    uint256 public mockAmountOut;
    // Mock ticks crossed
    uint32 public mockInitializedTicksCrossed;
    // Mock gas estimate
    uint256 public mockGasEstimate;
    
    // Store factory and WETH9 addresses to match interface
    address public immutable factory;
    address public immutable WETH9;

    constructor(address _factory, address _WETH9) {
        factory = _factory;
        WETH9 = _WETH9;
    }

    function setMockParameters(
        uint160 _mockSqrtPriceX96,
        uint256 _mockAmountOut,
        uint32 _mockInitializedTicksCrossed,
        uint256 _mockGasEstimate
    ) external {
        mockSqrtPriceX96 = _mockSqrtPriceX96;
        mockAmountOut = _mockAmountOut;
        mockInitializedTicksCrossed = _mockInitializedTicksCrossed;
        mockGasEstimate = _mockGasEstimate;
    }

    function quoteExactInputSingle(QuoteExactInputSingleParams memory)
        public
        override
        returns (
            uint256 amountOut,
            uint160 sqrtPriceX96After,
            uint32 initializedTicksCrossed,
            uint256 gasEstimate
        )
    {
        return (mockAmountOut, mockSqrtPriceX96, mockInitializedTicksCrossed, mockGasEstimate);
    }

    // Required interface implementations with minimal mock returns
    function quoteExactInput(bytes memory, uint256)
        public
        override
        returns (
            uint256,
            uint160[] memory,
            uint32[] memory,
            uint256
        )
    {
        revert("Not implemented");
    }

    function quoteExactOutputSingle(QuoteExactOutputSingleParams memory)
        public
        override
        returns (
            uint256,
            uint160,
            uint32,
            uint256
        )
    {
        revert("Not implemented");
    }

    function quoteExactOutput(bytes memory, uint256)
        public
        override
        returns (
            uint256,
            uint160[] memory,
            uint32[] memory,
            uint256
        )
    {
        revert("Not implemented");
    }
}
