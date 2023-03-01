// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//INTERNAL IMPORT FOR NFT OPRNZIPLINE
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";// will allow us how many users are creating nfts and number of tokens
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import "hardhat/console.sol";

contract NFTMarketplace is ERC721URIStorage{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    Counters.Counter private _itemsSold;
    uint256 listingPrice = 0.0025 ether;
    address payable owner;
    mapping(uint256 => MarketItem) private idMarketItem;
    struct MarketItem{
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold; // sold will be true or false
    }

    event idMarketItemCreated (
        uint256 indexed tokenId, // In Solidity, you'll see that events are defined using the “event” keyword and are emitted using the “emit” keyword. Placing the “indexed” keyword in front of a parameter name will store it as a topic in the log record. Without the keyword “indexed”, it will be stored as data.
        address seller,
        address owner,
        uint256 price,
        bool sold // sold will be true or false
    );
    modifier onlyOwner()
    { require(msg.sender==owner,"only owner of the contract can change the listing price");
    _;
    }
    constructor() ERC721("NFT Metaverse Token", "MYNFT"){
        owner == payable(msg.sender);
    }
    function updateListingPrice(uint256 _ListingPrice) public payable onlyOwner{
       listingPrice = _ListingPrice ;
    }
    function getListingPrice() public view returns(uint256)
    {
        return listingPrice;
    }
// let create "Create nft oken function"

    function creatToken(string memory tokenURI, uint256 price) public payable returns(uint256){
        _tokenIds.increment();

        uint256 newTokenId = _tokenIds.current();
        _mint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        createMarketItem(newTokenId, price);

        return newTokenId;
    }
    // creating market items
    function createMarketItem(uint256 tokenId, uint256 price) private {
        require(price>0,"price must be atleast 1");
        require(msg.value== listingPrice, "price must be equal to listing price");

        idMarketItem[tokenId] = MarketItem(
            tokenId,
            payable(msg.sender),
            payable(address(this)),
            price,
            false
        );

        _transfer(msg.sender, address(this), tokenId); 

        emit idMarketItemCreated(tokenId, msg.sender, address(this), price, false);

        

        
    }
 //function for resale token

        

    function reSellToken (uint256 tokenId, uint256 price) public payable {
            require(idMarketItem[tokenId].owner==msg.sender,"only item owner can perform this purchase");

            require(msg.value==listingPrice,"Price must be equal to listing price");

            idMarketItem[tokenId].sold= false;
            idMarketItem[tokenId].price =price;

            idMarketItem[tokenId].seller= payable(msg.sender);

            idMarketItem[tokenId].owner=payable(address(this));

            _itemsSold.decrement();

            _transfer(msg.sender, address(this), tokenId); 
    }

    //function create market sale

    function createMarketSale(uint256 tokenId) public payable{
        uint256 price = idMarketItem[tokenId].price;

        require(msg.value==price, " please submit the asking price in order to complete the purchase");

            idMarketItem[tokenId].sold= true;

            idMarketItem[tokenId].seller= payable(msg.sender);

            idMarketItem[tokenId].owner=payable(address(0));

            _itemsSold.increment();
    }

}





