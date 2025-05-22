# Contributor Incentive System

A Clarity smart contract that implements a token-based incentive system for open-source contributors.

## Overview

The Contributor Incentive System is designed to reward developers for their contributions to open-source projects. Contributors can receive tokens for their work, and project maintainers can pledge tokens to incentivize specific development tasks.

## Features

- Contributor token minting and burning
- Token pledges for development tasks
- Incentive distribution for valuable contributions
- Secure pledge management

## Functions

### Read-Only Functions

- `get-balance`: Check a developer's token balance
- `get-pledge`: View a developer's pledged tokens
- `get-incentive`: Check available incentives for a developer

### Public Functions

- `mint`: Create new tokens (admin only)
- `submit-contribution`: Use tokens to submit contributions
- `grant-incentive`: Distribute incentives to valuable contributors
- `pledge-tokens`: Lock tokens to incentivize specific tasks
- `revoke-pledge`: Retrieve previously pledged tokens
- `claim-incentive`: Claim earned incentive tokens

## Error Codes

- `err-permission-denied (u100)`: Operation restricted to contract owner
- `err-funds-insufficient (u101)`: Insufficient balance for operation
- `err-amount-invalid (u102)`: Amount must be greater than zero

