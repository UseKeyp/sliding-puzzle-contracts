// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract PuzzleNFT is ERC1155 {
    uint256 public constant Controller = 1;
    mapping(uint => mapping(address => bool)) public minted;

    constructor() ERC1155("https://ipfs.io/ipfs/bafybeihjjkwdrxxjnuwevlqtqmh3iegcadc32sio4wmo7bv2gbf34qs34a/{id}.json") {
        _mint(msg.sender, Controller, 1, "0xafa9f9f984e47d883db2d017d7ad589007c6a3e8");
    }

    function mint(bytes calldata adminSig, bytes memory data) external {
      require(_isValid(adminSig), "invalid signature");
      // require(alreadyMinted(_msgSender()), "already minted");
      uint tokenId = getTokenId(adminSig);
      minted[tokenId][_msgSender()] = true;
      _mint(_msgSender(), tokenId, 1, data);
    }

  function getTokenId(bytes calldata adminSig) public pure returns (uint) {
      // decode bytes and parse out tokenId from signature
      return 1;
  }

  function _isValid(bytes calldata adminSig) internal pure returns (bool) {
      // use ecrecover to get address of signer
      // check signer address == owner/admin address of contract
      // check msgSender == minter address in signed message
      // check block.timestamp <= timestamp + 100 in signed message
      // (timestamp necessary to prevent reuse of signature)
      return true;
  }
}