import { zkWallet } from "../config/zkSync";
import { ethers } from "ethers";
import { config } from "../config/env";

const abi = [
  "function mint(address to, string memory tokenURI) public returns (uint256)",
  "function burn(uint256 tokenId) public",
  "function ownerOf(uint256 tokenId) public view returns (address)"
];

const contract = new ethers.Contract(config.nftContract, abi, zkWallet);

export async function mintNFT(to: string, tokenURI: string) {
  const tx = await contract.mint(to, tokenURI);
  const receipt = await tx.wait();

  // Adjust for your contract’s event
  const tokenId = receipt.events[0].args[0].toString();
  return tokenId;
}

export async function burnNFT(tokenId: string) {
  const tx = await contract.burn(tokenId);
  await tx.wait();
}

export async function verifyNFTOwnership(tokenId: string, claimedOwner: string) {
  const actualOwner = await contract.ownerOf(tokenId);
  return actualOwner.toLowerCase() === claimedOwner.toLowerCase();
}
