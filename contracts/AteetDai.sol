// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// someone comes to site, they do first login and gets tokens
// someone comes and add there twitter handles and stuff, get more tokens
//
contract AteetDai is ERC20{
    constructor(uint256 initialSupply) ERC20("Ateet", "ATD"){
        _mint(msg.sender, initialSupply * (10** decimals()));
    }

    mapping(address => bool) firstLogins;
    mapping(address => bool) handlesSubmited;


    event LoginAdded(address indexed _to ,bool value);
    event SubmissionAdded(address indexed _to, bool value);
    event LuckyDrawSent(address indexed _to, bool value);

    modifier zeroAddress {
        require(_msgSender() != address(0), "User Can't Login With Zero Address");
        _;
    }

    modifier checkLogin {
        require(!firstLogins[_msgSender()]);
        _;
    }

    modifier checkSubmits {
        require(!handlesSubmited[_msgSender()]);
        _;
    }

    function login() public payable zeroAddress checkLogin{
        firstLogins[_msgSender()] = true;
        _mint(_msgSender(), 100);
        emit LoginAdded(_msgSender(), true);
    }

    function handleSubmit() public payable zeroAddress checkSubmits{
        handlesSubmited[_msgSender()] = true;
        _mint(_msgSender(), 100);
        emit SubmissionAdded(_msgSender(), true);
    }

    function handleLuckyDraw(uint256 luckyDrawAmount) public payable zeroAddress checkLogin checkSubmits{
        // uint256 amount = abi.decode(luckyDrawAmount, (uint256));
        _mint(_msgSender(), luckyDrawAmount);
        emit LuckyDrawSent(_msgSender(), true);
    }
}