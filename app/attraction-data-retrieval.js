import dotenv from 'dotenv';

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



async function getAttractionBrief(location) {
  try {
    const url = `https://booking-com15.p.rapidapi.com/api/v1/attraction/searchLocation?query=${location}`;
    const response = await fetch(url, options);
    const result = await response.json();
    const brief = [];

    const attractionLength = result.data.products.length;
    const attractionProduct = result.data.products;

    for(let i=0; i<attractionLength && i<5; i++) {
      brief.push([attractionProduct[i].productSlug, attractionProduct[i].title, attractionProduct[i].cityName.toLowerCase(), attractionProduct[i].countryCode]);
    }
    return brief;
  } catch (error) {
    console.error("Error while getting attraction brief:", error);
  }
}

await getAttractionBrief("jeddah")

async function getAttractionDetails(attractionBrief) {
     try { 
        const [slug, title, cityName, countryCode] = attractionBrief;

        const url = `https://booking-com15.p.rapidapi.com/api/v1/attraction/getAttractionDetails?slug=${slug}`;
        const response = await fetch(url, options);
        const result = await response.json();

        const data = result.data

        const photosArray = []

        for(let i=0; i<data.photos.length; i++) {
          photosArray.push(data.photos[i].small)
        }

        const attractionData = {
            cityName,
            countryCode,
            attractionName: title,
            attractionSlug: slug,
            images: photosArray,
            whatsIncluded: data.whatsIncluded,
            price: data.representativePrice.chargeAmount,
            cancellationPolicy: data.cancellationPolicy.hasFreeCancellation,
            additionalInfo: data.additionalInfo
        } 
        return attractionData;
    } catch (error) {
    console.error("Error while getting attraction data:", error);
  }
}


/**
 * DB Transcation
 * 1. Save location data to location table
 * 2. Get location IDs from location table
 * 3. Save flight data to flight table with location IDs as foreign keys
 * 4. Transaction management to ensure data integrity
 */

async function saveAttractionDetailsToDB(attractionData) {
  const client = await pool.connect();

  try {
    await client.query('BEGIN')

        // check if the location exists already using lowercase cityName
    const existenceQuery = `
      SELECT id
      FROM locations
      WHERE cityName = $1
    `;

    const result = await client.query(existenceQuery, [
      attractionData.cityName
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
        attractionData.cityName,
        attractionData.countryCode
      ]);

      locationId = insertResult.rows[0].id;
    }


    // insert flight data with locationId
    const attractionQueryText = 'INSERT INTO attractions(name, slug, additional_info, cancellation_policy, price, currency, location_id, whats_included, images) VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9)'

    await client.query(attractionQueryText, 
        [
        attractionData.attractionName, 
        attractionData.attractionSlug, 
        attractionData.additionalInfo, 
        attractionData.cancellationPolicy, 
        attractionData.price, 
        "USD", 
        locationId,
        attractionData.whatsIncluded,
        attractionData.images
        ]);

    await client.query('COMMIT')
  } catch (e) {
    await client.query('ROLLBACK')
    throw e
  } finally {
    client.release()
  }
}



const init = async () => {
    const attractionBriefs = [];
    for(const location of locations) {
        let sl = await getAttractionBrief(location)
        attractionBriefs.push(...sl)
    }

    for(const attractionBrief of attractionBriefs) {
        const details = await getAttractionDetails(attractionBrief);
        await saveAttractionDetailsToDB(details)
    }
}

await init();