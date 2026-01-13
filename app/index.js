import express from "express";
import dotenv from "dotenv";
import searchRouter from "./routes/search.route.js";
import detailsRouter from "./routes/details.route.js";

dotenv.config();
const PORT = process.env.PORT || 3000;

const app = express();
app.use(express.json());

app.use("/api/v1/search", searchRouter);
app.use("/api/v1/details", detailsRouter);


app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});