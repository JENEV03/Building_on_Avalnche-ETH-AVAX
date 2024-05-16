// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    mapping(uint256 => uint256) public srp;

    constructor() ERC20("Jenevive", "JEN") Ownable(msg.sender) {
        srp[1] = 500;
        srp[2] = 30;
        srp[3] = 20;
        srp[4] = 15;
    }


    function mintDGN(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }

    function transferDGN(address _to, uint256 _amount) public {
        require(balanceOf(msg.sender) >= _amount, "Transfer Failed: Insufficient balance.");
        approve(msg.sender, _amount);
        transferFrom(msg.sender, _to, _amount);
    }

    function showShopItems() external pure returns (string memory) {
        string memory saleOptions = "The items on sale: {1} Jen tokens (500) {2} Jen Jeans (30) {3} Jen Merchandise (20) {4} Jen accessories (15)";
        return saleOptions;
    }

    function redeemDGN(uint256 _item) public {
        require(srp[_item] > 0, "Item is not available.");
        require(_item <= 4, "Item is not available.");
        require(balanceOf(msg.sender) >= srp[_item], "Redeem Failed: Insufficient balance.");
        transfer(owner(), srp[_item]);
    }
    
    function burnDGN(uint256 _amount) public {
        require(balanceOf(msg.sender) >= _amount, "Burn Failed: Insufficient balance.");
        approve(msg.sender, _amount);
        _burn(msg.sender, _amount);
    }

    function getBalance() external view returns (uint256) {
        return this.balanceOf(msg.sender);
    }

    function decimals() override public pure returns (uint8) {
        return 0;
    }

    
}