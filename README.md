# Booking API

A backend REST API for getting **flights, and attractions** by location, built with **Node.js**, **Express**, and **PostgreSQL**. The API aggregates flight and attraction data by location.

---

## Features

* Location-based search
* Flights linked to locations
* Attractions linked to locations
* Search flights & attractions by location name
---

## Tech Stack

* **Node.js**
* **Express.js**
* **PostgreSQL**
* **pg** (PostgreSQL client)
* **dotenv** (environment variables)

---

## Project Structure

```sh
app/
├── controllers/        # Handles incoming HTTP requests and response logic
├── models/             # application models (Flight, Attraction, Location)
├── routes/             # Express route definitions and API endpoints
├── db/                 # Database connection and migrations
│   └── migrations/     # Schema versioning
├── database.sql        # exported pg dumb file
├── docker-compose.yml  # Docker setup for local PostgreSQL
├── .env                # Environment variables
├── package.json        # Project metadata and dependencies
├── index.js            # Application entry point
├── README.md           # Project documentation

```

---
## Setup & Installation

### Clone the repository

```bash
git clone git@github.com:Rai321han/booking_api.git
cd booking_api
```

### Install dependencies

```bash
npm install
```

### Configure environment variables

Create a `.env` file:

```env
PORT= //server port
POSTGRES_USER=postgres username
POSTGRES_PASSWORD=postgres password
POSTGRES_DB=databse name
POSTGRES_PORT=postgres port
RAPIDAPI_HOST='booking-com15.p.rapidapi.com'
RAPIDAPI_KEY=rapid api key
DATABASE_URL=postgresql://dbuser:dbpassword@host:5432/dbname
```

---

## API Example

### Search Flights & Attractions by Location

**Endpoint**

```http
GET /api/search/:searchLocation
```

**Response**

```json
{
  "GeoInfo": {
    "name": "jeddah",
    "country": "SA"
  },
  "Flights": [...],
  "Attractions": [...]
}
```


**Endpoint**

```http
GET /api/details/:id?searchtype=flight/attraction
```

**Response**

```json
{
  "GeoInfo": {
    "name": "jeddah",
    "country": "SA"
  },
  "Flights": {...}
}
```
---

## Author

**Raihan Uddin**
- Software Engineer Intern, W3 Engineers Ltd.