// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC1155Base.sol";

contract Contract is ERC1155Base {
    constructor(
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps
    ) ERC1155Base(_name, _symbol, _royaltyRecipient, _royaltyBps) {}

    address public winner;

    /**
        The user can increase the supply of current token.
        The tokenId of First NFT is 0
        The tokenId of Second NFT is 1
     */
    function mintNFTSupplyTo(uint256 _tokenId) public virtual {
        address caller = msg.sender;

        // Second NFT
        if (_tokenId == 1) {
            uint256 firstNFTbalance = balanceOf[caller][0];
            require(firstNFTbalance >= 1, "Not enough First NFT tokens owned");
        }

        // Third NFT
        if (_tokenId == 2) {
            require(caller == winner, "Only the winner can mint this NFT");
            require(
                totalSupply[_tokenId] < 1,
                "The third NFT supply must 1 or less."
            );
        }

        _mint(caller, _tokenId, 1, "");
    }

    function setWinner(address _winner) public virtual onlyOwner {
        winner = _winner;
    }
}
