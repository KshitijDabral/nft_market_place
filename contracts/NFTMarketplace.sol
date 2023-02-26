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
        bool sold; // 
    }

    event idMarketItemCreated (
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold // 
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
    function createMarketItem(uint256 tokenID, uint256 price) private {
        require(price>0,"price must be atleast 1");
        require(msg.value== listingPrice, "price must be equal to listing price");
    }
}





