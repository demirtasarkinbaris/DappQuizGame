// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/QuizGame.sol";

interface CheatCodes {
    function deal(address, uint256) external;
}

contract QuizGameTest is Test {
    QuizGame public game;
    CheatCodes constant cheats = CheatCodes(HEVM_ADDRESS);

    function setUp() public {
        string memory question = "What is your name?";
        string memory answer = "Eschkiya23";
        bytes32 salt = bytes32("123123123");
        bytes32 hashedAnswer = keccak256(abi.encodePacked(salt, answer));

        emit log_bytes32(hashedAnswer);
        game = new QuizGame(question, hashedAnswer);
        emit log(game.question());
    }

    function testQuizFail() public {
        try game.guess("baris") {
            assertTrue(false);
        } catch {
            assertTrue(true);
        }
    }

    function testQuizPass() public {
        uint256 beginBalance = address(this).balance;
        cheats.deal(address(game), 10000);
        game.guess("Eschkiya23");
        assertEq(address(this).balance, beginBalance + 10000);
    }

    fallback() external payable {}

    receive() external payable {}
}
