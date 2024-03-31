const express = require("express");
const app = express();
const cors = require("cors");
const pool = require("./db");
const port = 5000;

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

//middleware
app.use(cors());;
app.use(express.json());


//ROUTES//

// Route to handle hotel search
app.get("/hotels", async (req, res) => {
  try {
    // Extract parameters from the request
    const { area, hotelChain, hotelCategory, totalRooms } = req.query;
    // Construct the SQL query
    const query = `
       SELECT *
       FROM hotel
       WHERE hotel_address ILIKE $1
         AND central_office_address ILIKE $2
         AND star_rating = $3
         AND EXISTS (
           SELECT 1
           FROM room
           WHERE room.hotel_address = hotel.hotel_address
             AND room.capacity >= $4
         )
     `;

    // Execute the SQL query
    
    const { rows } = await pool.query(query, [
      `%${area}%`,
      `%${hotelChain}%`,
      hotelCategory,
      totalRooms,
    ]);

    // Send the response with the fetched hotels
    res.json({ hotels: rows });
  } catch (error) {
    // Handle errors
    console.error("Error executing query:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.get("/rooms", async (req, res) => {
  try {
    // Extract parameters from the request
    const {
      startDate,
      endDate,
      location,
      roomCapacity,
      roomPrice,
      amenities,
      starRating,
    } = req.query;

    // Construct the SQL query
    let query = `
       SELECT r.*
       FROM room r
       JOIN hotel h ON r.hotel_address = h.hotel_address
       JOIN RoomAmenity ra ON r.room_number = ra.room_number AND r.hotel_address = ra.hotel_address
       WHERE r.booking_start_date >= $1
       AND r.booking_end_date <= $2
       AND r.capacity >= $3
       AND h.area ILIKE $4
       AND h.star_rating = $5
       AND r.price <= $6
     `;

    const queryParams = [
      startDate,
      endDate,
      roomCapacity,
      `%${location}%`,
      starRating,
      roomPrice,
    ];

    if (amenities) {
      const amenityList = amenities.split(",");
      const placeholders = amenityList
        .map((_, index) => `$${index + 7}`)
        .join(", ");
      query += ` AND ra.amenity_id IN (${placeholders})`;
      queryParams.push(...amenityList);
    }

    // Execute the SQL query
    const { rows } = await pool.query(query, queryParams);

    // Send the response with the fetched rooms
    res.json({ rooms: rows });
  } catch (error) {
    // Handle errors
    console.error("Error executing query:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});


