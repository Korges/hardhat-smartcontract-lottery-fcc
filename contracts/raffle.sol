// Raffle
// Enter the lottery (paying some amount)
// Pick random winnder (verifiably random)
// Winnger to be selected every X minutes -> completly automated
// Chainlink Oracle -> Randomness, Automated Execution (Chainlink Keeper)


// SPDS-License-Identifier: MIT

pragma solidity ^0.8.7;

// import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";

error Raffle_NotEnoughETHEntered();

contract Raffle is VRFConsumerBaseV2 {
    /* State Variables */
    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    /* Events */
    event RaffleEnter(address indexed player);

    constructor(address vrfCoordinatorV2, uint256 entranceFee) VRFConsumerBaseV2(vrfCoordinatorV2) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {
        // require (msg.value < i_entranceFee, 'Not enough ETH!")
        if (msg.value < i_entranceFee) {
            revert Raffle_NotEnoughETHEntered();
        }
        s_players.push(payable(msg.sender));
        // Emit an event when we update a dynamic array or mapping
        // Named events with the function name reversed
        emit RaffleEnter(msg.sender);
    } 

    function requestRandomWinner() external {
        // Request the random number
        // Once we get it, do something with it
        // 2 transaction process


    }

    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {

    }

    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }

    function getPlayer(uint256 index) public view returns(address) {
        return s_players[index];
    }
}
