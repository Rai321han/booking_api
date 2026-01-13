import Location from "../models/location.model.js";
import Flight from "../models/flight.model.js";
import Attraction from "../models/attraction.model.js";


/**
 * Search flights & attractions by location name
 */
export const searchByLocation = async (req, res, next) => {
  try {
    const { searchLocation } = req.params;


    // Find location
    const location = await Location.findByName(searchLocation);
    if (!location) {
      return res.status(404).json({
        message: "Location not found",
      });
    }

    // Get flights under this location
    const flights = await Flight.findByLocationId(location.id);
    const attractions = await Attraction.findByLocationId(location.id);

    console.log(attractions[0])

    const attractionData = attractions.map(attraction => (
      {
        id: attraction.id,
        name: attraction.name,
        slug: attraction.slug,
        additionalInfo: attraction.additional_info,
        price: attraction.price + " USD",
        cancellationPolicy: attraction.cancellation_policy,
        whatsIncluded: attraction.whats_included,
        images: attraction.images
      }
    ))
    const flightData = flights.map((flight) => (
      {
        id: flight.id,
        flightName: flight.flight_name,
        logo: flight.flight_logo,
        fare: flight.fare + " USD",
        departureTime: flight.departure_time,
        arrivalTime: flight.arrival_time,
        departureAirport: flight.departure_airport,
        arrivalAirport: flight.arrival_airport
      }
    ))

    res.status(200).json({
      GeoInfo: {
        location: location.cityname,
        country: location.countrycode,
      },
      Flights: flightData.length === 0 ? "No flights data" : flightData,
      Attractions: attractionData.length === 0 ? "No attractions data" : attractionData, // to be implemented
    });
  } catch (error) {
    next(error);
  }
};
