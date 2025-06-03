// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title GameToken - ERC20 token for testing purposes
contract GameToken is ERC20, Ownable {
    constructor() ERC20("GameToken", "GT") {
        // initial supply of 10,000,000 tokens to the deployer
        _mint(msg.sender, 10000000 * 10 ** decimals());
    }

    /// @notice Mint new tokens, only callable by the owner
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
