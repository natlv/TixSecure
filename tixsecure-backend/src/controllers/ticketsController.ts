import { Request, Response, NextFunction } from "express";
import { mintNFT, burnNFT, verifyNFTOwnership } from "../services/zkSyncService";
import { saveTicket, deleteTicket } from "../services/dynamoDBService";
import logger from "../utils/logger";

export const mintTicket = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { to, tokenURI } = req.body;
    const tokenId = await mintNFT(to, tokenURI);

    await saveTicket({
      ticketId: tokenId,
      owner: to,
      tokenURI,
    });

    res.status(201).json({ message: "NFT Ticket minted!", tokenId });
  } catch (err) {
    logger.error(err);
    next(err);
  }
};

export const burnTicket = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { tokenId } = req.body;
    await burnNFT(tokenId);
    await deleteTicket(tokenId);

    res.json({ message: "NFT Ticket burned!" });
  } catch (err) {
    logger.error(err);
    next(err);
  }
};

export const authenticateTicket = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const { tokenId, owner } = req.body;
    const isOwner = await verifyNFTOwnership(tokenId, owner);

    res.json({ valid: isOwner });
  } catch (err) {
    logger.error(err);
    next(err);
  }
};
