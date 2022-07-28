// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract VintageJerseyNFT is
    ERC721,
    ERC721Enumerable,
    ERC721URIStorage,
    Ownable
{
    constructor() ERC721("VintageJerseyNFT", "VJNFT") {}

    using Counters for Counters.Counter;

    Counters.Counter private _jerseyIdCounter;

    struct NewJersey {
        address payable owner;
        uint256 price;
        bool isSold;
    }

    mapping(uint256 => NewJersey) private jerseys;

    modifier exist(uint256 _tokenId) {
        require(_exists(_tokenId), "Query of non existent jersey");
        _;
    }


    modifier checkPrice(uint _price){
          require(_price > 0, "Price must be at least 1");
          _;
    }

    /// @dev function to upload a jersey
    function uploadJersey(string calldata _uri, uint256 _price) external checkPrice(_price) {
        require(bytes(_uri).length > 0, "Empty uri");
        uint256 _tokenId = _jerseyIdCounter.current(); //initializing the token ID to the current count
        _jerseyIdCounter.increment();

        jerseys[_tokenId] = NewJersey(
            payable(msg.sender),
            _price,
            false //initializing the value of isSold to false for newly uploaded jerseys
        );
        _safeMint(msg.sender, _tokenId); //minting the jersey
        _setTokenURI(_tokenId, _uri); //creating a url using the token ID and the uri provided
    }

    /// @dev function to buy a jersey using a token ID
    function buyJersey(uint256 _tokenId) external payable exist(_tokenId)  {
        uint256 _jerseyPrice = jerseys[_tokenId].price; //assigning the NFT price to a variable
        bool _isSold = jerseys[_tokenId].isSold; //assigning the NFT isSold property to a variable
        require(!_isSold, "Item already sold"); //item must be available for sale
        require(
            msg.value == _jerseyPrice,
            "Please submit the asking price in order to complete the purchase"
        ); // price of the NFT must be met
        require(
            msg.sender != jerseys[_tokenId].owner,
            "Sorry, you can't buy your uploaded jersey"
        ); // the buyer must not be the owner

        address _owner = jerseys[_tokenId].owner;
        jerseys[_tokenId].owner = payable(msg.sender); //changing the owner variable of the NFT to the buyer
        jerseys[_tokenId].isSold = true; // setting isSold to true
        jerseys[_tokenId].price = 0;
        (bool success, ) = payable(_owner).call{value: _jerseyPrice}(""); //tranfering money to the seller of the NFT
        require(success, "Payment for jersey failed");
        _transfer(_owner, msg.sender, _tokenId); //transfering ownership of the NFT to the buyer
    }

    /// @dev function to put a jersey on sale
    function sellJersey(uint256 _tokenId, uint256 _price) external exist(_tokenId) checkPrice(_price) {
        require(jerseys[_tokenId].isSold, "Item already on sale"); //item must be available for sale
        require(
            msg.sender == jerseys[_tokenId].owner,
            "Only owner is allowed to resale jersey"
        );
        jerseys[_tokenId].isSold = false; // setting isSold to true
        jerseys[_tokenId].price = _price;
    }

    /// @dev function to get the jerseys uploaded using its index
    function readJersey(uint256 _tokenId)
        public
        view
        exist(_tokenId)
        returns (
            address payable,
            uint256,
            bool
        )
    {
        return (
            jerseys[_tokenId].owner,
            jerseys[_tokenId].price,
            jerseys[_tokenId].isSold
        );
    }

    /// @dev getting the length of jerseys uploaded
    function getJerseyLength() public view returns (uint256) {
        return _jerseyIdCounter.current();
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
