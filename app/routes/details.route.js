import { Router } from "express";
import { getDetails } from "../controllers/details.controller.js"
import { errorHandler } from "../middlewares/errorHandler.js";

const detailsRouter = Router();



detailsRouter.get("/:id", getDetails, errorHandler);

export default detailsRouter;