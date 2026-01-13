import { query } from "../db/query.js"


class Flight {
  /**
   * Create a new flight
   */
  static async create({
    flight_name,
    flight_logo,
    fare,
    departure_time,
    arrival_time,
    departure_airport,
    arrival_airport,
    location_id,
  }) {
    const sql = `
      INSERT INTO flights (
        flight_name,
        flight_logo,
        fare,
        departure_time,
        arrival_time,
        departure_airport,
        arrival_airport,
        location_id
      )
      VALUES ($1,$2,$3,$4,$5,$6,$7,$8)
      RETURNING *
    `;

    const values = [
      flight_name,
      flight_logo,
      fare,
      departure_time,
      arrival_time,
      departure_airport,
      arrival_airport,
      location_id,
    ];

    const { rows } = await query(sql, values);
    return rows[0];
  }

  /**
   * Find flight by ID
   */
  static async findById(id) {
    const sql = `
      SELECT f.*, l.cityName, l.countryCode
      FROM flights f
      JOIN locations l ON f.location_id = l.id
      WHERE f.id = $1
    `;
    const { rows } = await query(sql, [id]);
    return rows[0];
  }

  /**
   * Find flights by location
   */
  static async findByLocationId(locationId) {
    const sql = `
      SELECT *
      FROM flights
      WHERE location_id = $1
      ORDER BY departure_time
    `;
    const { rows } = await query(sql, [locationId]);
    return rows;
  }
}

export default Flight;
