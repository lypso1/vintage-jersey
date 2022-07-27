<!-- ABOUT THE PROJECT -->
![Africa Cuisine NFT Marketplace Logo](https://i.ibb.co/x53TSmr/Grill-food-Logo.png)

## About The Project

This project was built for [Celo Development 201 - Build an NFT Minter with Hardhat and React](https://dacade.org/communities/celo/courses/celo-201) 
It was built with the idea to showcase and celebrate Africa Delicacies through an NFT Marketplace. 

[Check it Out](https://greatnessss.github.io/Africa-Cuisine-NFT-Marketplace/)

### Technologies used

Frameworks and libraries used in this project include:

* [React.js](https://reactjs.org/)
* [Hardhat](https://hardhat.org/getting-started/)
* [Solidity](https://docs.soliditylang.org/en/v0.8.11/)
* [Openzeppelin](https://openzeppelin.com/)
* [Bootstrap](https://getbootstrap.com)
* [Celo-tools](https://docs.celo.org/learn/developer-tools)
## :point_down: Getting Started

To get this project up running locally, follow these simple example steps.

### Prerequisites

You will need node and yarn installed.

### Installation

Step-by-step guide to running this NFT minter locally;

1. Clone the repo
   ```sh
   git clone [Africa Cuisine NFT Marketplace](https://github.com/greatnessss/Africa-Cuisine-NFT-Marketplace.git)
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

Step-by-step guide to redeploying the NFT smart contract using your address to enable you mint NFTs.

1. Compile the smart contract
   ```sh
   npx hardhat compile
   ```
2. Run tests on smart contract
   ```sh
   npx hardhat test
   ```
3. Update env file

* Create a file in the root directory called ".env"
* Create a key called MNEMONIC and paste in your mnemonic key. e.g
     ```js
   MNEMONIC="xxxx ggg hhhhh hhhff hhhh hijj cddd hill"
   ```
You can get your MNEMONIC from Metamask Recovery security phrase in settings

4. Deploy the smart contract
   ```sh
    npx hardhat run scripts/deploy.js
   ```
5. Run the project
   ```sh
    npm start
   ```

## Contributing

To contribut to this project, please follow the steps listed below. 

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also
simply open an issue with the tag "enhancement". Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch 
3. Commit your Changes 
4. Push to the Branch 
5. Open a Pull Request

