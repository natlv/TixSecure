import { Router } from "express";
import {
  mintTicket,
  burnTicket,
  authenticateTicket
} from "../controllers/ticketsController";

const router = Router();

router.post("/mint", mintTicket);
router.post("/burn", burnTicket);
router.post("/authenticate", authenticateTicket);

export default router;
