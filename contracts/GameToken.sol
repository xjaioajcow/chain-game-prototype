// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title GameToken - ERC20 token for testing purposes
contract GameToken is ERC20, Ownable {
}

    /// @notice Mint new tokens, only callable by the owner
    function mint(address to, uint256 amount) external onlyOwner {

    constructor() ERC20("GGT", "GGT") Ownable(msg.sender) {
    _mint(msg.sender, 10000000 * 10 ** decimals());
}}
}
