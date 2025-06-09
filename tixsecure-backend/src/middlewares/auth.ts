import { jwtVerify } from "jose";
import { Request, Response, NextFunction } from "express";
import { config } from "../config/env";

declare global {
  namespace Express {
    interface Request {
      user?: any;
    }
  }
}

const secret = new TextEncoder().encode(config.jwtSecret);

export const auth = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return res.status(401).json({ error: "Authorization token missing or malformed" });
    }

    const token = authHeader.split(" ")[1];
    const { payload } = await jwtVerify(token, secret);

    req.user = payload;
    next();
  } catch (err) {
    return res.status(401).json({ error: "Invalid or expired token" });
  }
};
