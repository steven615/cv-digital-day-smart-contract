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

    /**
        The user can increase the supply of current token.
        The tokenId of First NFT is 0
        The tokenId of Second NFT is 1
     */
    function mintNFTSupplyTo(uint256 _tokenId) public virtual {
        address caller = msg.sender;
        require(_tokenId == 0 || _tokenId == 1, "invalid id");

        if (_tokenId == 1) {
            uint256 firstNFTbalance = balanceOf[caller][0];
            require(firstNFTbalance >= 1, "Not enough First NFT tokens owned");
            _burn(caller, 0, firstNFTbalance);
        }

        _mint(caller, _tokenId, 1, "");
    }
}
