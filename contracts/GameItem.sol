// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title GameItem - ERC721 NFT contract for testing purposes
contract GameItem is ERC721, ERC721URIStorage, Ownable {
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

    /// @notice Mint a new NFT, only callable by the owner
    function mintItem(address to, uint256 tokenId, string calldata tokenURI) external onlyOwner {
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }

    /// @notice Burn an existing NFT, only callable by the token owner or contract owner
    function burnItem(uint256 tokenId) external {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "Caller is not owner nor approved");
        _burn(tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}
