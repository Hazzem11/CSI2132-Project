const express = require("express");
const app = express();
const cors = require("cors");
const pool = require("./db");
const port = 5000;

//middleware
app.use(cors());;
app.use(express.json());


//ROUTES//

// Route to handle hotel search
app.get("/hotels", async (req, res) => {
  try {
    const { area, hotelChain, hotelCategory, totalRooms } = req.query;
    // Construct the SQL query
    const query = `
    SELECT *
    FROM hotel h
    WHERE h.hotel_address ILIKE $1
      AND h.central_office_address ILIKE $2
      AND h.star_rating = $3
      AND (
        SELECT COUNT(*)
        FROM Room r
        WHERE r.hotel_address = h.hotel_address
      ) >= $4
     `;
    
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
    SELECT *
    FROM room r
    JOIN hotel h ON r.hotel_address = h.hotel_address
    JOIN RoomAmenity ra ON r.room_number = ra.room_number AND r.hotel_address = ra.hotel_address
    WHERE (
            (r.booking_start_date >= $1 OR r.booking_start_date IS NULL)
            AND (r.booking_end_date <= $2 OR r.booking_end_date IS NULL)
          )
          AND r.capacity >= $3
          AND h.hotel_address ILIKE $4
          AND h.star_rating = $5
          AND r.price <= $6;
`;

const queryParams = [
  `${startDate}`,
  `${endDate}`,
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

app.get("/login", async (req, res) => {
  try {
    // Extract parameters from the request
    const {
      fullName,
    } = req.query;

    // Construct the SQL query
    const query = `
      SELECT customer_ssn AS user_ssn, customer_full_name AS user_full_name, customer_address AS user_address, 'Customer' AS user_type
      FROM Customer
      WHERE customer_full_name ILIKE $1
      UNION
      SELECT employee_ssn AS user_ssn, employee_full_name AS user_full_name, employee_address AS user_address, 'Employee' AS user_type
      FROM Employee
      WHERE employee_full_name ILIKE $1;
    `;

const queryParams = [
  `%${fullName}%`
];

    // Execute the SQL query
    const { rows } = await pool.query(query, queryParams);

    // Send the response with the fetched rooms
    res.json({ users: rows });
  } catch (error) {
    // Handle errors
    console.error("Error executing query:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});
app.get("/bookings", async (req, res) => {
  try {
    // Extract parameters from the request
    const {
      fullName,
    } = req.query;

    // Construct the SQL query
    const query = `
    SELECT *
    FROM Booking
    JOIN Customer ON Booking.customer_ssn = Customer.customer_ssn
    WHERE Customer.customer_full_name ILIKE $1;
    `;

const queryParams = [
  `%${fullName}%`
];

    // Execute the SQL query
    const { rows } = await pool.query(query, queryParams);

    // Send the response with the fetched rooms
    res.json({ bookings: rows });
  } catch (error) {
    // Handle errors
    console.error("Error executing query:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
