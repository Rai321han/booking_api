import AppError from "../../utils/AppError.js";
import Attraction from "../models/attraction.model.js";
import Flight from "../models/flight.model.js";
/**
 * Get details by ID and type
 */
export const getDetails = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { searchtype } = req.query;

    if (!searchtype) {
      throw new AppError("searchtype query is required", 400)
    }


    const trimedSearchType = searchtype.trim()

    if (trimedSearchType === "flight") {
      const flight = await Flight.findById(id);

      if (!flight) {
        throw new AppError("Flight not found", 404)
      }

      const flightData =  {
          flightName: flight.flight_name,
          logo: flight.flight_logo,
          fare: flight.fare + " USD",
          departureTime: flight.departure_time,
          arrivalTime: flight.arrival_time,
          departureAirport: flight.departure_airport,
          arrivalAirport: flight.arrival_airport
        }
    

      return res.status(200).json({
        GeoInfo: {
          location: flight.cityname,
          country: flight.countrycode,
        },
        Flight: flightData ? flightData : "No flight under this location."
      });
    }

    if (trimedSearchType === "attraction") {
      const attraction = await Attraction.findById(id);

      if (!attraction) {
        throw new AppError("Attraction not found", 404)
      }

      const attractionData =   {
        id: attraction.id,
        name: attraction.name,
        slug: attraction.slug,
        additionalInfo: attraction.additional_info,
        price: attraction.price + " USD",
        cancellationPolicy: attraction.cancellation_policy,
        whatsIncluded: attraction.whats_included,
        images: attraction.images
      }
    

      return res.status(200).json({
        GeoInfo: {
          location: attraction.cityname,
          country: attraction.countrycode,
        },
        Attraction: attractionData ? attractionData : "No attraction under this location."
      });
    }
    throw new AppError("Invalid searchtype value", 400)

  } catch (error) {
    next(error);
  }
};
