// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract VintageJerseyNFT is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    constructor() ERC721("VintageJerseyNFT", "VJNFT") {}

    using Counters for Counters.Counter;

    Counters.Counter private count;
    uint256 internal jerseyLength = 0;

    struct NewJersey {
        address payable owner;
        string name;
        string image;
        string description;
        uint256 tokenId;
        uint256 price;
        bool isSold;
    }

    mapping(uint256 => NewJersey) internal jerseys;

    function createToken(string memory uri, uint256 _tokenId) internal returns (uint256) {

        require(_tokenId == jerseys[_tokenId].tokenId , "Sorry, no image with this ID was found");
        require(msg.sender == jerseys[_tokenId].owner, "Sorry, only the owner of this NFT can mint this NFT");

        uint256 tokenId = jerseys[_tokenId].tokenId;

        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, uri);

        return tokenId;
    }

    function uploadJersey(
        string memory _name,
        string memory _image,
        string memory _description,
        string memory _uri,
        uint256 _price
    ) public {
        require(_price > 0, "Price must be at least 1");

        uint256 _tokenId = count.current();
        bool _isSold = false;

        jerseys[jerseyLength] =  NewJersey(
            payable(msg.sender),
            _name,
            _image,
            _description,
            _tokenId,
            _price,
            _isSold
        );

        createToken(_uri, _tokenId);
        
        jerseyLength ++;
        count.increment();
    }

    function buyJersey(
        uint256 _tokenId
    ) public payable {
        uint256 _jerseyPrice = jerseys[_tokenId].price;
        bool _isSold = jerseys[_tokenId].isSold;

        require(msg.value >= _jerseyPrice, "Please submit the asking price in order to complete the purchase");
        require(msg.sender != jerseys[_tokenId].owner, "Sorry, you can't buy your uploaded jersey");
        require(!_isSold, "Item already sold");
        require(_tokenId == jerseys[_tokenId].tokenId, "Oops...NFT does not exist");

        address _owner = ownerOf(_tokenId);
        _transfer(_owner, msg.sender, _tokenId);
        
        jerseys[_tokenId].owner.transfer(msg.value);

        jerseys[_tokenId].owner = payable(msg.sender);
        jerseys[_tokenId].isSold = true;
    }

    function readJersey(uint256 _index) public view returns (
        address payable,
        string memory,
        string memory,
        string memory,
        uint256,
        uint256,
        bool
    ) {
        return (
            jerseys[_index].owner,
            jerseys[_index].name,
            jerseys[_index].image,
            jerseys[_index].description,
            jerseys[_index].tokenId,
            jerseys[_index].price,
            jerseys[_index].isSold
        );
    }

    function getJerseyLength() public view returns (uint256) {
        return jerseyLength;
    }

    function isSold(uint256 _index) public view returns (bool) {
        return jerseys[_index].isSold;
    }



    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
