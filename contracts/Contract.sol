// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC1155Drop.sol";

contract Contract is ERC1155Drop {
    constructor(
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps,
        address _primarySaleRecipient
    )
        ERC1155Drop(
            _name,
            _symbol,
            _royaltyRecipient,
            _royaltyBps,
            _primarySaleRecipient
        )
    {}

    function _beforeClaim(
        uint256 _tokenId,
        address _receiver,
        uint256,
        address,
        uint256,
        AllowlistProof calldata,
        bytes memory
    ) internal view virtual override {
        if (_tokenId >= nextTokenIdToLazyMint) {
            revert("Not enough minted tokens");
        }

        // Second NFT
        if (_tokenId == 1) {
            uint256 firstNFTbalance = balanceOf[_receiver][0];
            require(firstNFTbalance >= 1, "Not enough First NFT tokens owned");
        }

        // Third NFT
        if (_tokenId == 2) {
            uint256 firstNFTbalance = balanceOf[_receiver][0];
            require(firstNFTbalance >= 1, "Not enough First NFT tokens owned");

            uint256 secondNFTbalance = balanceOf[_receiver][1];
            require(
                secondNFTbalance >= 1,
                "Not enough Second NFT tokens owned"
            );

            require(
                totalSupply[_tokenId] < 1,
                "The third NFT supply must 1 or less."
            );
        }
    }
}
