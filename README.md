<!-- ABOUT THE PROJECT -->
# Vintage Jersey
```
```
## About The Project

This project was built built to give users the ability to show their love for vintage jersey and creating beatiful NFT wit their vintage jersey.

[Click here to see](https://lypso1.github.io/vintage-jersey/)

### Languages/tools used for this project includes

* [React.js](https://reactjs.org/)
* [Hardhat](https://hardhat.org/getting-started/)
* [Solidity](https://docs.soliditylang.org/en/v0.8.11/)
* [Openzeppelin](https://openzeppelin.com/)
* [Bootstrap](https://getbootstrap.com)
* [Celo-tools](https://docs.celo.org/learn/developer-tools)
## :point_down: Getting Started

### Prerequisites

You will need node and yarn installed.

### Installation

Step-by-step guide to running this NFT minter locally;

1. Clone the repo
   ```sh
   git clone [Vintage Jersey NFT Marketplace](https://github.com/lypso1/vintage-jersey.git)
   ```
2. Install NPM packages
   ```sh
   npm install
   ```

3. Run your application
   ```sh
   npm start
   ```

### Smart-Contract-Deployment

Compile the smart contract
   ```sh
   npx hardhat compile
   ```
Run tests on smart contract
   ```sh
   npx hardhat test
   ```
Update env file

* Create a file in the root directory called ".env"
* Create a key called MNEMONIC and paste in your mnemonic key. e.g
     ```
   MNEMONIC="xxxx xxxx xxxx xxxx xxxx xxxx"
   ```
You can get your MNEMONIC from Metamask Recovery security phrase in settings

Deploy the smart contract
   ```sh
    npx hardhat run scripts/deploy.js
   ```
Run the project
   ```sh
    npm start
   ```
#  Thank you
