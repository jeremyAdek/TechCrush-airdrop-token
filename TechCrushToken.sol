// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract TechCrushToken is ERC20, Ownable {

    constructor() ERC20("TechCrush Airdrop Token", "TCT") Ownable(msg.sender){
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function airdrop(address[] calldata recipients, uint256[] calldata amounts) external onlyOwner {
        require(recipients.length == amounts.length, "Recipients and amounts arrays must have same length");
        require(recipients.length > 0, "Must provide at least one recipient");

        for (uint i = 0; i < recipients.length; i++) {
            require(recipients[i] != address(0), "Cannot send to zero address");
            _transfer(owner(), recipients[i], amounts[i]);
        }
    }
}