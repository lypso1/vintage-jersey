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

    modifier onlyOwner(uint256 _tokenId){
        require(msg.sender == jerseys[_tokenId].owner, "Only the owner can acess this function");
        _;
    }

    function createToken(string memory uri, uint256 _tokenId) internal returns (uint256) {

        require(_tokenId == jerseys[_tokenId].tokenId , "Sorry, no image with this token ID was found");    // token ID must exist before it can be minted
        require(msg.sender == jerseys[_tokenId].owner, "Sorry, only the owner of this NFT can mint this NFT");  // only the owner of a jersey can mint the jersey

        uint256 tokenId = jerseys[_tokenId].tokenId;

        _safeMint(msg.sender, tokenId); //minting the jersey
        _setTokenURI(tokenId, uri); //creating a url using the token ID and the uri provided

        return tokenId;
    }

// function to upload a jersey
    function uploadJersey(
        string memory _name,
        string memory _image,
        string memory _description,
        string memory _uri,
        uint256 _price
    ) public {
        require(_price > 0, "Price must be at least 1");

        uint256 _tokenId = count.current(); //initializing the token ID to the current count
        bool _isSold = false;   //initializing the value of isSold to false for newly uploaded jerseys

        jerseys[jerseyLength] =  NewJersey(
            payable(msg.sender),
            _name,
            _image,
            _description,
            _tokenId,
            _price,
            _isSold
        );

        createToken(_uri, _tokenId);    //minting the jersey as soon as it is uploaded by calling the createToken function
        
        jerseyLength ++;
        count.increment();
    }

// function to buy a jersey using a token ID
    function buyJersey(
        uint256 _tokenId
    ) public payable {
        uint256 _jerseyPrice = jerseys[_tokenId].price; //assigning the NFT price to a variable
        bool _isSold = jerseys[_tokenId].isSold;    //assigning the NFT isSold property to a variable

        require(msg.value >= _jerseyPrice, "Please submit the asking price in order to complete the purchase"); // price of the NFT must be met
        require(msg.sender != jerseys[_tokenId].owner, "Sorry, you can't buy your uploaded jersey");    // the buyer must not be the owner
        require(!_isSold, "Item already sold"); //item must be available for sale
        require(_tokenId == jerseys[_tokenId].tokenId, "Oops...NFT does not exist");    //item must exist

        address _owner = ownerOf(_tokenId);
        _transfer(_owner, msg.sender, _tokenId);    //transfering ownership of the NFT to the buyer
        
        jerseys[_tokenId].owner.transfer(msg.value);    //tranfering money to the seller of the NFT

        jerseys[_tokenId].owner = payable(msg.sender);  //changing the owner variable of the NFT to the buyer
        jerseys[_tokenId].isSold = true;    // setting isSold to true
    }

// function to get the jerseys uploaded using its index
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

    //Function to sell the jersey
    function sellJersey(uint256 _index, uint _price) external onlyOwner(_index){
        jerseys[_index].isSold = false;
        jerseys[_index].isSold = _price;
    }

    //Function to change the price of the jersey
    function changePrice(uint256 _index, uint _price) external onlyOwner(_index){
        jerseys[_index].price = _price;
    }

// getting the length of jerseys uploaded
    function getJerseyLength() public view returns (uint256) {
        return jerseyLength;
    }

// returuning the value of isSold as a function
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
