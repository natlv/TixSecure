import { Provider, Wallet as ZkWallet } from "zksync-ethers";
import { Wallet as EthWallet, JsonRpcProvider } from "ethers";
import { config } from "../config/env";

const zkProvider = new Provider(config.zkSyncNode);
const ethProvider = new JsonRpcProvider(config.ethRpcUrl);

const ethWallet = new EthWallet(config.privateKey, ethProvider);
const zkWallet = new ZkWallet(config.privateKey, zkProvider);

export { zkProvider, zkWallet, ethWallet };



