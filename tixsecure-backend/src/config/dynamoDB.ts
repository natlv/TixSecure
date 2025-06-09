import AWS from "aws-sdk";
import { config } from "./env";

AWS.config.update({ region: config.awsRegion });

const dynamoClient = new AWS.DynamoDB.DocumentClient();

export { dynamoClient };
