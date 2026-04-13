# 🎓 Certificate Verification System using Blockchain

A tamper-proof, trustless certificate verification system built on Ethereum using Solidity and Hardhat.

## 🔍 Overview

Educational certificates are routinely forged or tampered with. This system stores a cryptographic hash of each certificate on an immutable blockchain ledger. Any tampering changes the hash, instantly revealing fraud. Verification is instant and trustless — no need to contact the issuing institution.

## ⚙️ Tech Stack

- **Solidity ^0.8.20** — Smart Contract
- **Hardhat** — Local Blockchain Network
- **OpenZeppelin AccessControl** — Role-Based Access Control
- **Ethers.js v5** — Frontend Blockchain Interaction
- **MetaMask** — Wallet & Transaction Signing
- **HTML/CSS/JS** — Frontend

## 🏗️ Architecture

### Smart Contract — `CertificateVerification.sol`
- `ADMIN_ROLE` — Registers and revokes institution wallets
- `INSTITUTION_ROLE` — Issues certificates on-chain
- Public `view` functions — Anyone can verify without a wallet or gas

### Consensus Algorithm — Proof of Authority (PoA)
PoA is used because validators are known trusted entities (universities, government bodies), it provides instant transaction finality, consumes no energy unlike Proof of Work, and requires no token economics — making it ideal for permissioned institutional environments.

## 🚀 Getting Started

### Prerequisites
- Node.js v18+
- MetaMask Browser Extension

### Installation

```bash
git clone https://github.com/kushalkumarcs372/-Certificate-Verification-System-using-Blockchain-.git
cd -Certificate-Verification-System-using-Blockchain-
npm install
```

### Run Local Blockchain

```bash
npx hardhat node
```

### Deploy Contract (new terminal)

```bash
npx hardhat ignition deploy ignition/modules/Deploy.js --network localhost
```

### Launch Frontend

Open `frontend/index.html` in your browser.

## 📋 Features

- ✅ Admin registers/revokes institution wallets
- ✅ Institutions issue certificates with cryptographic hash
- ✅ Unique on-chain certificate ID per certificate
- ✅ Duplicate certificate prevention
- ✅ Verify by Certificate ID or Hash
- ✅ Returns issuer, student ID, and issuance timestamp
- ✅ Immutable — past certificates survive institution revocation
