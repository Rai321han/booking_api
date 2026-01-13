import { query } from "../db/query.js"

class Location {
    static async create(name, country) {
        const lowerCaseName = name.toLowerCase();
        const sql = `
            INSERT INTO locations (cityName, countryCode)
            VALUES ($1, $2)
            RETURNING *
            `;
        const { rows } = await query(sql, [lowerCaseName, country]);
        return rows[0];
    }

    /**
   * Find location by name
   */
    static async findByName(name) {
        const lowerCaseName = name.toLowerCase(); 
        const sql = `
        SELECT *
        FROM locations
        WHERE cityName = $1
        `;
        const { rows } = await query(sql, [lowerCaseName]);
        return rows[0];
    }

    /**
     * Find location by ID
     */
    
    static async findById(id) {
        const sql = `
        SELECT *
        FROM locations
        WHERE id = $1
        `;
        const { rows } = await query(sql, [id]);
        return rows[0];
    }
}
export default Location
