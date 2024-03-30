const express = require("express");
const app = express();
const cors = require("cors");
const pool = require("./db");
const port = 5000;

//middleware
app.use(cors());
app.use(express.json());


//ROUTES//
// Route to handle hotel search
app.get('/hotels', async (req, res) => {
  try {
     // Extract parameters from the request
     const { startDate, endDate, roomCapacity, area, hotelChain, hotelCategory, totalRooms, roomPrice } = req.query;

     // Construct the SQL query
     const query = `
        SELECT *
        FROM hotels
        WHERE start_date >= $1
        AND end_date <= $2
        AND room_capacity >= $3
        AND area ILIKE $4
        AND hotel_chain ILIKE $5
        AND hotel_category = $6
        AND total_rooms >= $7
        AND room_price <= $8
     `;

     // Execute the SQL query
     const { rows } = await pool.query(query, [startDate, endDate, roomCapacity, area, hotelChain, hotelCategory, totalRooms, roomPrice]);

     // Send the response with the fetched hotels
     res.json({ hotels: rows });
  } catch (error) {
     // Handle errors
     console.error('Error executing query:', error);
     res.status(500).json({ error: 'Internal server error' });
  }
});


app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
