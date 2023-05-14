// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";

/// @custom:security-contact team@usekeyp.com
contract PuzzleNFT is Ownable, ERC1155URIStorage {
    struct UserHasMinted {
      bool isValue;
    }

    mapping(address => bool) isMinter;
    mapping(uint256 => mapping(address => UserHasMinted)) public tokenIdToOwner;
    string public baseURI;

    constructor(string memory _baseURI) ERC1155(_baseURI) {
        isMinter[msg.sender] = true;
        baseURI = _baseURI;
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(address account, uint256 id) public {
        require(isMinter[msg.sender], "Only minter address is allowed to mint");
        require(tokenIdToOwner[id][account].isValue != true, "Maximum 1 token per address");
        _mint(account, id, 1, ""); // mints 1 NFT of chosen ID
        tokenIdToOwner[id][account] = UserHasMinted(true);
    }

    function addMinter(address _minter) public onlyOwner {
        isMinter[_minter] = true;
    }

    function removeMinter(address _minter) public onlyOwner {
        isMinter[_minter] = false;
    }

    function updateBaseURI(string memory _based) public onlyOwner {
        _setBaseURI(_based);
    }

    function uri(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        // If token URI is set, concatenate base URI and tokenURI (via abi.encodePacked).
        //Note to dev: upload a folder to IPFS that has all the jsons in it numbered and named 1.json for example.
        return string(abi.encodePacked(baseURI, tokenId, ".json"));
    }
}
