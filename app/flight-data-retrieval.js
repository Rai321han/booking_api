import dotenv from 'dotenv';
// import { pool } from './db/connection';

dotenv.config();

import pg from 'pg';

const { Pool } = pg;

const connectionString = process.env.DATABASE_URL;

const pool = new Pool({
    connectionString,
    max: 20,
    min: 4,
})


const locations = ["Jeddah", "Auckland"]


const options = {
  method: 'GET',
  headers: {
    'x-rapidapi-key': process.env.RAPIDAPI_KEY,
    'x-rapidapi-host': process.env.RAPIDAPI_HOST
  }
};



async function getAirportId(location) {
  try {
    const url = `https://booking-com15.p.rapidapi.com/api/v1/flights/searchDestination?query=${location}`;
    const response = await fetch(url, options);
    const result = await response.json();
    const airports = [];

    for(let i=0; i<result.data.length && i<3; i++) {
      airports.push(result.data[i].id)
    }

    return airports;
  } catch (error) {
    console.error("Error while getting airport IDs:", error);
  }
}


async function getFlightToken(form, to, date) {
   try {
    const url = `https://booking-com15.p.rapidapi.com/api/v1/flights/searchFlights?fromId=${form}&toId=${to}&departDate=${date}`;
    const response = await fetch(url, options);
    const result = await response.json();

    const tokens = [];

    for(let i=0; i<result.data.flightOffers.length && i<5; i++) {
      tokens.push(result.data.flightOffers[i].token);
    }
    return tokens;
  } catch (error) {
    console.error("Error while getting flight tokens:", error);
  }
}


async function getFlightDetails(token) {
     try {  
      const url = `https://booking-com15.p.rapidapi.com/api/v1/flights/getFlightDetails?token=${token}`;
      const response = await fetch(url, options);
      const result = await response.json();

      const segments = result.data.segments;
      const priceBreakDown = result.data.priceBreakdown;

      const data = {
        cityName: segments[0].departureAirport.cityName.toLowerCase(),
        countryCode: segments[0].departureAirport.country,
        departureAirport: segments[0].departureAirport.name,
        arrivalAirport: segments[0].arrivalAirport.name,
        departureTime: segments[0].legs[0].departureTime,
        arrivalTime: segments[0].legs[0].arrivalTime,
        flightName: segments[0].legs[0].carriersData[0].name,
        flightLogo: segments[0].legs[0].carriersData[0].logo,
        fare: priceBreakDown.total.units,
        fareCurrency: priceBreakDown.total.currencyCode
      } 

      return data;
    } catch (error) {
    console.error("Error while getting flight and location data:", error);
  }
}


// get airport ids for locations
async function getAirportIdsCombinations() {
  const airportIds1 = await getAirportId(locations[0])
  const airportIds2 = await getAirportId(locations[1])
  
  const combinations = []
  // combination of airport ids
  for(const id1 of airportIds1) {
      for(const id2 of airportIds2) {
          combinations.push([id1, id2]);
          combinations.push([id2, id1]);
      }
  }
  return combinations;
}


/**
 * 1. Save location data to location table
 * 2. Get location IDs from location table
 * 3. Save flight data to flight table with location IDs as foreign keys
 * 4. Transaction management to ensure data integrity
 */

async function saveFlightDetailsToDB(flightData) {
  const client = await pool.connect();

  console.log(flightData)

  try {
    await client.query('BEGIN')

         // check if the location exists already using lowercase cityName
    const existenceQuery = `
      SELECT id
      FROM locations
      WHERE cityName = $1
    `;

    const result = await client.query(existenceQuery, [
      flightData.cityName
    ]);

    let locationId;

    if (result.rowCount > 0) {
      // location exists
      locationId = result.rows[0].id;
    } else {
      // location does not exist → insert
      const insertQuery = `
        INSERT INTO locations (cityName, countryCode)
        VALUES ($1, $2)
        RETURNING id
      `;

      const insertResult = await client.query(insertQuery, [
        flightData.cityName,
        flightData.countryCode
      ]);

      locationId = insertResult.rows[0].id;
    }

    // insert flight data with locationId
    const flightQueryText = 'INSERT INTO flights(location_id, departure_time, arrival_time, flight_name, flight_logo, fare, departure_airport, arrival_airport) VALUES($1, $2, $3, $4, $5, $6, $7, $8)'

    await client.query(flightQueryText, [locationId, flightData.departureTime, flightData.arrivalTime, flightData.flightName, flightData.flightLogo, flightData.fare, flightData.departureAirport, flightData.arrivalAirport]);

    await client.query('COMMIT')
    console.log("DONE")
  } catch (e) {
    await client.query('ROLLBACK')
    throw e
  } finally {
    client.release()
  }
}

const init = async () => {
  const combinations = await getAirportIdsCombinations();
  const flightTokens = [];
  for(const combo of combinations) {
      const fromId = combo[0];
      const toId = combo[1];
      const departDate = '2026-01-13';
      tokens = await getFlightToken(fromId, toId, departDate);
      flightTokens.push(...tokens);
  }

  for(const token of flightTokens) {
      const flightData = await getFlightDetails(token);
      await saveFlightDetailsToDB(flightData);
  }
  
}

await init();