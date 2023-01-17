//SPDX-license-identifier: MIT

pragma solidity ^ 0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract LW3Punks is ERC721Enumerable, Ownable{
    using Strings for uint256;

    string _baseTokenURI;
    uint public _price = 0.01 ether;
    bool public _paused;
    uint public maxTokenIds = 10;
    uint public tokenIds;

    modifier onlyWhenNotPaused {
        require(!_paused, "Contract is currently paused.");
        _;
    }

    constructor (string memory baseURI) ERC721("LearnWeb3Punks", "LW3P") {
        _baseTokenURI = baseURI;
    }
    
    function mint() public payable onlyWhenNotPaused {
        require(tokenIds < maxTokenIds, "all tokens have been minted.");
        require(msg.value >= _price, "insufficient offer, sorry!");
        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory){
        require(_exists(tokenIds), "ERC721 Metadata, URI inqury for non-existent token.");
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenIds.toString(), ".json")) : "";
    }
    function setPause(bool _val) public onlyOwner{
        _paused = _val;
    }
    function withdraw() public onlyOwner{
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");
        require (sent, "failed to send contract balance.");
    }
    receive() external payable {}

    fallback() external payable {}
}

