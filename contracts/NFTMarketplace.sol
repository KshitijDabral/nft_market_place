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

    constructor() ERC721("NFT Metaverse Token", "MYNFT"){
        owner == payable(msg.sender);
    }
}


