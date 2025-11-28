// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ChainFluxVault
 * @dev A simple vault contract demonstrating deposit, withdraw, and balance tracking
 */
contract ChainFluxVault {

    mapping(address => uint256) private balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    /**
     * @dev Deposit ETH into the vault
     */
    function deposit() external payable {
        require(msg.value > 0, "Deposit must be greater than zero.");

        balances[msg.sender] += msg.value;

        emit Deposited(msg.sender, msg.value);
    }

    /**
     * @dev Withdraw ETH from the vault
     * @param amount The amount to withdraw in wei
     */
    function withdraw(uint256 amount) external {
        require(amount > 0, "Amount must be > 0.");
        require(balances[msg.sender] >= amount, "Insufficient balance.");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

        emit Withdrawn(msg.sender, amount);
    }

    /**
     * @dev Returns the balance of the calling user
     */
    function getMyBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
