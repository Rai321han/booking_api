/**
 * @type {import('node-pg-migrate').ColumnDefinitions | undefined}
 */
export const shorthands = undefined;

/**
 * @param pgm {import('node-pg-migrate').MigrationBuilder}
 * @param run {() => void | undefined}
 * @returns {Promise<void> | void}
 */
export const up = (pgm) => {
    pgm.sql(
        `
        CREATE TABLE flights (
            id SERIAL PRIMARY KEY,
            flight_name VARCHAR(50) NOT NULL,
            flight_logo VARCHAR(255),
            fare DECIMAL(10, 2) NOT NULL,
            departure_time TIMESTAMP WITH TIME ZONE NOT NULL,
            arrival_time TIMESTAMP WITH TIME ZONE NOT NULL,
            departure_airport VARCHAR(255) NOT NULL,
            arrival_airport VARCHAR(255) NOT NULL,
            location_id INT REFERENCES locations(id) ON DELETE CASCADE,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );
            `
    )
};

/**
 * @param pgm {import('node-pg-migrate').MigrationBuilder}
 * @param run {() => void | undefined}
 * @returns {Promise<void> | void}
 */
export const down = (pgm) => {
    pgm.sql(`DROP TABLE flights;`);
};
