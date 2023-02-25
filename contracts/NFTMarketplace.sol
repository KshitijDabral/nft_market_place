// SPDX-License-identifier: MIT;
pragma solidity ^0.8.4;

//INTERNAL IMPORT FOR NFT OPRNZIPLINE
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";// will allow us how many users are creating nfts and number of tokens
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import "hardhat/console.sol";

contract NFTMarketplace is ERC721URIStorage{
    using Counters for Counters.counter;

    
}


