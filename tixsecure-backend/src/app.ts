import express from "express";
import cors from "cors";
import morgan from "morgan";
import router from "./routes";
import { errorHandler } from "./middlewares/errorHandler";

const app = express();

app.use(cors());
app.use(express.json());
app.use(morgan("dev"));

app.use("/api", router);

app.use(errorHandler);

export default app;
