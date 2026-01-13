// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/access/Ownable.sol";

contract VotingToken is ERC20, Ownable {
    constructor() ERC20("Jeremy Voting Token", "JVT") Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}

contract Voting is Ownable {
    struct Election {
        string title;
        string[] candidates;
        uint256 endTime;
        bool active;
    }

    Election[] public elections;

    mapping(uint256 => mapping(address => bool)) public hasVoted;
    mapping(uint256 => mapping(uint256 => uint256)) public votes;

    function createElection(
        string memory _title,
        string[] memory _candidates,
        uint256 _durationInMinutes
    ) external onlyOwner {
        require(_candidates.length >= 2, "Need at least 2 candidates");

        uint256 endTime = block.timestamp + (_durationInMinutes * 60);

        Election memory newElection = Election({
            title: _title,
            candidates: _candidates,
            endTime: endTime,
            active: true
        });

        elections.push(newElection);
    }
}
