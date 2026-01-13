import { pool } from "./connection.js";

/**
 * Executes a SQL query using the provided query text and parameters.
 *
 * @param {string} text - The SQL query string.
 * @param {Array} [params=[]] - Optional array of parameters for the SQL query.
 * @returns {Promise<object>} - A Promise that resolves to the query result.
 */


const query = async (text, params = []) => {
    const result = await pool.query(text, params);
    return result;
}

export { query };