import { Router } from "express";
import {searchByLocation} from "../controllers/search.controller.js"
import { errorHandler } from "../middlewares/errorHandler.js";

const searchRouter = Router();

searchRouter.get("/:searchLocation", searchByLocation, errorHandler);

export default searchRouter;