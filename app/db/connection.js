import pg from "pg";
import dotenv from "dotenv"
dotenv.config();

const { Pool } = pg;

const connectionString = process.env.DATABASE_URL;
const pool = new Pool({
    connectionString,
    max: 20,
    min: 4,
})

export { pool };