# SendWithdrawMoney Smart Contract

## Overview
The `SendWithdrawMoney` contract enables users to deposit Ether into the contract and allows authorized users to withdraw funds either to their own address or to a specified address. It also tracks the total amount of Ether received by the contract.

## Features
- **Deposit Ether:** Users can deposit Ether into the contract.
- **View Contract Balance:** Anyone can view the current balance held in the contract.
- **Withdraw Funds:**
  - Withdraw all funds to the caller's address.
  - Withdraw all funds to a specified address.

## Contract Details

### Solidity Version
- Compatible with Solidity **^0.8.30**.

### License
- GPL-3.0 License

### State Variables
- `balanceRecived`: Stores the total amount of Ether received by the contract (note: typo in variable name).

### Functions

| Function Name           | Description                                                  | Visibility  | Payable | Notes                                                        |
|-------------------------|--------------------------------------------------------------|-------------|---------|--------------------------------------------------------------|
| `deposit()`             | Deposit Ether into the contract and update total received.  | `public`    | `payable` | Send Ether with the transaction, updates `balanceRecived`. |
| `getContractBalance()`  | View the current Ether balance of the contract.              | `public view` | -       | Useful to check available funds in the contract.            |
| `withdrawAll()`         | Withdraw all Ether to the caller's address.                  | `public`    | -       | Transfers entire balance to `msg.sender`.                   |
| `withdrawToAddress()`   | Withdraw all Ether to a specified address.                   | `public`    | -       | Transfers entire balance to provided `address payable`.   |

## Usage Instructions

### Depositing Ether
Call the `deposit()` function while sending Ether:

```solidity
contractInstance.deposit({value: <amount>});

### Viewing Contract Balance

Check the balance via:


```uint balance = contractInstance.getContractBalance();

### Withdrawing Funds


To withdraw all funds to your address:


```contractInstance.withdrawAll();


To withdraw all funds to a specific address:


```contractInstance.withdrawToAddress(<payable_address>);

###Security Considerations


The current implementation allows any user to call withdrawal functions, which may not be desirable in production. Consider adding access controls (e.g., onlyOwner) to restrict withdrawals.

Using transfer() mitigates reentrancy concerns, but always consider additional security best practices for real-world deployments.

Always validate that withdrawals are made by authorized parties if needed.
