// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

/// @title GameCore - Core game logic contract framework
/// @notice This contract is a placeholder for core game functions. Implementation will be added later.
contract GameCore is Ownable {
    IERC20 public gameToken;    // game token contract
    IERC721 public gameItem;    // NFT contract

    // example time parameters
    uint256 public landCoolDown = 24 hours;
    uint256 public sailDurationSafe = 6 hours;
    uint256 public sailDurationRisk = 2 hours;

constructor(address _gameToken, address _gameItem) Ownable(msg.sender) {
    gameToken = IERC20(_gameToken);
    gameItem  = IERC721(_gameItem);
}}

    /// @notice Plant land
    function plantLand(uint256 landId) external {
        // TODO: implement
    }

    /// @notice Harvest land
    function harvest(uint256 landId) external {
        // TODO: implement
    }

    /// @notice Start sailing
    function startSail(uint256 fleetId, bool isRisky) external {
        // TODO: implement
    }

    /// @notice Claim voyage rewards
    function claimVoyage(uint256 fleetId) external {
        // TODO: implement
    }

    /// @notice Raid a pirate
    function raidPirate(uint256 pirateId) external {
        // TODO: implement
    }

    /// @notice Upgrade ship
    function upgradeShip(uint256 shipId) external {
        // TODO: implement
    }

    /// @notice Start an auction
    function startAuction(
        uint256 itemId,
        uint256 startPrice,
        uint256 duration
    ) external {
        // TODO: implement
    }

    /// @notice Bid in an auction (payable)
    function bidAuction(uint256 auctionId) external payable {
        // TODO: implement
    }

    /// @notice End an auction
    function endAuction(uint256 auctionId) external {
        // TODO: implement
    }
}
