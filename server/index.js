const express = require("express");
const app = express();
const cors = require("cors");
const pool = require("./db");
const port = 3001;

//middleware
app.use(cors());
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
    const { startDate, endDate, roomCapacity, hotel_address, roomPrice } =
      req.query;

    // Construct the SQL query
    let query = `
  SELECT r.room_number, r.*
  FROM room r
  JOIN hotel h ON r.hotel_address = h.hotel_address
  WHERE (
    (r.booking_start_date >= $1)
    AND (r.booking_end_date <= $2)
  )
  AND r.capacity >= $3
  AND h.hotel_address ILIKE $4
  AND r.price <= $5;
`;

    const queryParams = [
      `${startDate}`,
      `${endDate}`,
      roomCapacity,
      hotel_address,
      roomPrice,
    ];

    // Execute the SQL query
    console.log(queryParams)
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
    const { fullName } = req.query;

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

    const queryParams = [`%${fullName}%`];

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
    const { fullName } = req.query;

    // Construct the SQL query
    const query = `
    SELECT *
    FROM Booking
    JOIN Customer ON Booking.customer_ssn = Customer.customer_ssn
    WHERE Customer.customer_full_name ILIKE $1;
    `;

    const queryParams = [`%${fullName}%`];

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
app.get("/rentings", async (req, res) => {
  try {
    // Extract parameters from the request
    const { fullName } = req.query;

    // Construct the SQL query
    const query = `
    SELECT *
    FROM Renting
    JOIN Customer ON Renting.customer_ssn = Customer.customer_ssn
    WHERE Customer.customer_full_name ILIKE $1;
    `;

    const queryParams = [`%${fullName}%`];

    // Execute the SQL query
    const { rows } = await pool.query(query, queryParams);

    // Send the response with the fetched rooms
    res.json({ rentings: rows });
  } catch (error) {
    // Handle errors
    console.error("Error executing query:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});
app.post("/renting", async (req, res) => {
  try {
    const {
      customer_full_name,
      room_number,
      hotel_address,
      employee_full_name,
      renting_start_date,
    } = req.body;

    const customerQuery = `
      SELECT customer_ssn
      FROM Customer
      WHERE customer_full_name ILIKE $1;
    `;
    const employeeQuery = `
      SELECT employee_ssn
      FROM Employee
      WHERE employee_full_name ILIKE $4;
    `;

    const { rows: customerRows } = await pool.query(customerQuery, [
      `%${customer_full_name}%`,
    ]);
    const { rows: employeeRows } = await pool.query(employeeQuery, [
      `%${employee_full_name}%`,
    ]);

    if (customerRows.length === 0) {
      console.log("No1");
    }
    if (employeeRows.length === 0) {
      console.log("No2");
    }

    const customer_ssn = customerRows[0].customer_ssn;
    const employee_ssn = employeeRows[0].employee_ssn;

    const rentingQuery = `
      INSERT INTO Renting (customer_ssn, room_number, hotel_address, employee_ssn, renting_start_date)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *;
    `;

    const { rows: rentingRows } = await pool.query(rentingQuery, [
      customer_ssn,
      room_number,
      hotel_address,
      employee_ssn,
      renting_start_date,
    ]);

    res
      .status(201)
      .json({
        renting: rentingRows[0],
        message: "Renting created successfully",
      });
  } catch (error) {
    console.error("Error creating renting:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});
app.post("/booking", async (req, res) => {
  try {
    const { customer_full_name, room_number, hotel_address, booking_date } =
      req.body;

    const customerQuery = `
      SELECT customer_ssn
      FROM Customer
      WHERE customer_full_name ILIKE $1;
    `;

    const { rows: customerRows } = await pool.query(customerQuery, [
      `%${customer_full_name}%`,
    ]);

    if (customerRows.length === 0) {
      console.log("No1");
    }

    const customer_ssn = customerRows[0].customer_ssn;

    const bookingQuery = `
      INSERT INTO Booking (customer_ssn, room_number, hotel_address, booking_date)
      VALUES ($1, $2, $3, $4)
      RETURNING *;
    `;

    const { rows: bookingRows } = await pool.query(rentingQuery, [
      customer_ssn,
      room_number,
      hotel_address,
      booking_date,
    ]);

    res
      .status(201)
      .json({
        booking: bookingRows[0],
        message: "Booking created successfully",
      });
  } catch (error) {
    console.error("Error creating Booking:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
