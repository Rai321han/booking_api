import { query } from "../db/query.js";

class Attraction {
  /**
   * Create a new attraction
   */
  static async create({
    name,
    slug,
    additional_info,
    cancellation_policy,
    price,
    currency = "USD",
    whats_included,
    location_id,
  }) {
    const sql = `
      INSERT INTO attractions (
        name,
        slug,
        additional_info,
        cancellation_policy,
        price,
        currency,
        whats_included,
        location_id
      )
      VALUES ($1,$2,$3,$4,$5,$6,$7,$8)
      RETURNING *
    `;

    const values = [
      name,
      slug,
      additional_info,
      cancellation_policy,
      price,
      currency,
      whats_included,
      location_id,
    ];

    const { rows } = await query(sql, values);
    return rows[0];
  }

  /**
   * Find attraction by ID
   */
  static async findById(id) {
    const sql = `
      SELECT a.*, l.cityName, l.countryCode
      FROM attractions a
      JOIN locations l ON a.location_id = l.id
      WHERE a.id = $1
    `;
    const { rows } = await query(sql, [id]);
    return rows[0];
  }

  /**
   * Find attractions by location
   */
  static async findByLocationId(locationId) {
    const sql = `
      SELECT *
      FROM attractions
      WHERE location_id = $1
      ORDER BY created_at DESC
    `;
    const { rows } = await query(sql, [locationId]);
    return rows;
  }
}

export default Attraction;
