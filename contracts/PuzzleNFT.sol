// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";

/// @custom:security-contact team@usekeyp.com
contract PuzzleNFT is ERC1155, Ownable, ERC1155URIStorage{
    mapping (uint  id => string uri) someMapping;
    address public minter;

    constructor() ERC1155("") {
      minter = msg.sender;
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(
        address account,
        uint256 id,
    ) public {
        require(msg.sender == minter);
        _mint(account, id, 1, ""); // mints 1 NFT of chosen ID
    }

    function updateMinter(address _minter) onlyOwner {
      minter = _minter;
    }

    function updateBaseURI(string memory _based) onlyOwner{
        _setBaseURI(based);
    }

    function uri(uint256 tokenId) public view virtual override returns (string memory) {
      string memory tokenURI = _tokenURIs[tokenId];

      // If token URI is set, concatenate base URI and tokenURI (via abi.encodePacked).
      //Note to dev: upload a folder to IPFS that has all the jsons in it numbered and named 1.json for example.
      return string(abi.encodePacked(_baseURI, tokenURI, ".json"));
    }

}
