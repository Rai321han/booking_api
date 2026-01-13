import { Router } from "express";
import { getDetails } from "../controllers/details.controller.js"

const detailsRouter = Router();



detailsRouter.get("/:id", getDetails);

export default detailsRouter;