import { dynamoClient } from "../config/dynamoDB";
import { config } from "../config/env";

export const saveTicket = async (ticket: { ticketId: string; owner: string; tokenURI: string }) => {
  const params = {
    TableName: config.dynamoTable,
    Item: ticket,
  };
  await dynamoClient.put(params).promise();
};

export const deleteTicket = async (ticketId: string) => {
  const params = {
    TableName: config.dynamoTable,
    Key: { ticketId },
  };
  await dynamoClient.delete(params).promise();
};
