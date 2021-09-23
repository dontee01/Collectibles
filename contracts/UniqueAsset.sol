pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract UniqueAsset is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    // track all minted tokens(including burnt/destroyed tokens)
    Counters.Counter public mintedToken;
    mapping(string => uint8) hashes;
    uint public totalSupply;

    constructor() ERC721("UniqueAsset", "UNA") {
        totalSupply = 20000;
    }

    function createNFT(address recipient, string memory hash, string memory metadata) 
    public
    returns(uint256)
    {
        // check for rarity
        require(mintedToken.current() < totalSupply, "Maximum NFT ALREADY MINTED");
        require(hashes[hash] != 1);
        
        hashes[hash] = 1;
        _tokenIds.increment();
        mintedToken.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(recipient, newItemId);
        _setTokenURI(newItemId, metadata);

        return newItemId;
    }

    // function _setTokenURI(uint256 tokenId, string memory hash) internal virtual {
    //     require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
    //     _tokenURIs[tokenId] = _tokenURI;
    // }
}