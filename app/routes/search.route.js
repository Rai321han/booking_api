import { Router } from "express";
import {searchByLocation} from "../controllers/search.controller.js"

const searchRouter = Router();

searchRouter.get("/:searchLocation", searchByLocation);

export default searchRouter;