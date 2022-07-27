import {useContract} from './useContract';
import vintageJerseyNFTAbi from '../contracts/VintageJerseyNFT.json';
import vintageJerseyNFTContractAddress from '../contracts/VintageJerseyNFT-address.json';


// export interface for NFT contract
export const useVintageJerseyContract = () => useContract(vintageJerseyNFTAbi.abi, vintageJerseyNFTContractAddress.VintageJerseyNFT);
