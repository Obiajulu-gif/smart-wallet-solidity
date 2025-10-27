# SendWithdrawMoney Smart Contract

## Overview
The `SendWithdrawMoney` contract lets users deposit Ether into the contract and allows authorized withdrawals either to the caller or to a specified address. It also tracks the total amount of Ether received by the contract.

## Features
- Deposit Ether into the contract.
- View the contract's current Ether balance.
- Withdraw all funds to the caller's address.
- Withdraw all funds to a specified payable address.

## Contract Details

### Solidity Version
- Compatible with Solidity ^0.8.0.

### License
- GPL-3.0

### State Variables
- `balanceReceived`: Stores the cumulative total amount of Ether received by the contract (note: original code used a misspelled name — README uses the corrected `balanceReceived`).

### Functions

| Function Name           | Description                                                  | Visibility    | Payable  | Notes                                                       |
|-------------------------|--------------------------------------------------------------|---------------|----------|-------------------------------------------------------------|
| `deposit()`             | Deposit Ether into the contract and update total received.   | `public`      | `payable`| Send Ether with the transaction; updates `balanceReceived`. |
| `getContractBalance()`  | Return the current Ether balance of the contract.            | `public view` | -        | Use to check available funds.                               |
| `withdrawAll()`         | Withdraw all Ether to the caller's address.                  | `public`      | -        | Transfers entire balance to `msg.sender` (implementation-dependent). |
| `withdrawToAddress()`   | Withdraw all Ether to a specified address.                   | `public`      | -        | Transfers entire balance to provided `address payable`.     |

## Usage Instructions

### Depositing Ether
Using ethers.js (example):
```javascript
// Send 0.1 ETH to the contract using deposit()
await contract.deposit({ value: ethers.utils.parseEther("0.1") });
```

### Viewing Contract Balance
Using ethers.js:
```javascript
const balance = await contract.getContractBalance();
console.log("Contract balance (ETH):", ethers.utils.formatEther(balance));
```

### Withdrawing Funds
Withdraw all funds to the caller's address:
```javascript
await contract.withdrawAll();
```

Withdraw all funds to a specific payable address:
```javascript
await contract.withdrawToAddress("0xYourTargetPayableAddressHere");
```

Note: The call examples assume you have a signer connected that is allowed to call these functions if the contract enforces access control.

## Security Considerations
- Access control: The example contract (as described) allows anyone to call withdrawal functions. In most production use-cases you should restrict withdrawals to authorized accounts (e.g., using OpenZeppelin Ownable and `onlyOwner` or a role-based access control).
- Reentrancy: Do not rely on low-level assumptions to prevent reentrancy. Use checks-effects-interactions pattern and consider using OpenZeppelin's `ReentrancyGuard` for non-reentrant functions.
- Transfers: The old `transfer()` can fail with certain gas changes. Prefer using `call` with proper error handling (and follow checks-effects-interactions), or rely on pull-payment patterns when appropriate.
- Validation: Validate destination addresses when withdrawing (e.g., ensure they are not zero address) and emit events for deposits and withdrawals to provide auditable logs.
- Testing & auditing: Thoroughly test contract behavior on testnets and consider a security review for contracts that handle real funds.

## Notes
- If your contract source uses the original misspelled variable (`balanceRecived`), either rename it in the contract to `balanceReceived` to match this README, or update the README to refer to the exact variable name in your source.
- This README focuses on description and usage. For implementation-level security and gas optimization, review the actual Solidity contract code and adjust recommendations accordingly.
