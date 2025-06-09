import dotenv from "dotenv";
dotenv.config();

export const config = {
  port: process.env.PORT || 3000,
  awsRegion: process.env.AWS_REGION!,
  dynamoTable: process.env.DYNAMO_TABLE!,
  privateKey: process.env.PRIVATE_KEY!,
  zkSyncNode: process.env.ZKSYNC_NODE_URL!,
  ethRpcUrl: process.env.ETH_RPC_URL!,
  nftContract: process.env.NFT_CONTRACT_ADDRESS!,
  jwtSecret: process.env.JWT_SECRET!,
};


