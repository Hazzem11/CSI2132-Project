const express = require("express");
const app = express();
const cors = require("cors");
const pool = require("./db");
const e = require("express");
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
      `${startDate.trim()}`,
      `${endDate.trim()}`,
      parseInt(roomCapacity.trim()),
      `%${hotel_address.trim()}%`,
      parseInt(roomPrice.trim()),
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
    console.log("AAAAAAAAAAAAAAAAAAAAAAAA");
    // Construct the SQL query
    const query = `
      SELECT customer_ssn AS user_ssn, customer_full_name AS user_full_name, customer_address AS user_address, 'Customer' AS user_type, 'NULL' AS hotel_address
      FROM Customer
      WHERE customer_full_name ILIKE $1
      UNION
      SELECT employee_ssn AS user_ssn, employee_full_name AS user_full_name, employee_address AS user_address, 'Employee' AS user_type, hotel_address AS hotel_address
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
    const {
      fullName,
      employeeFullName
    } = req.query;
    const customerQuery = `
      SELECT customer_ssn
      FROM Customer
      WHERE customer_full_name ILIKE $1;
    `;
    const employeeQuery = `
      SELECT hotel_address
      FROM Employee
      WHERE employee_full_name ILIKE $1;
    `;


    const { rows: customerRows } = await pool.query(customerQuery, [`%${fullName}%`]);
    const { rows: employeeRows } = await pool.query(employeeQuery, [`%${employeeFullName}%`]);

   
    const customer_ssn = customerRows[0].customer_ssn;
    const hotel_address = employeeRows[0].hotel_address;
    // Construct the SQL query
    const query = `
    SELECT *
    FROM Booking
    JOIN Customer ON Booking.customer_ssn = Customer.customer_ssn
    WHERE Customer.customer_ssn = $1
    AND hotel_address ILIKE $2;
    `;

const queryParams = [
  customer_ssn,
  `%${hotel_address}%`
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
app.get("/rentings", async (req, res) => {
  try {
    // Extract parameters from the request
    const {
      fullName,
      employeeFullName
    } = req.query;
    const customerQuery = `
      SELECT customer_ssn
      FROM Customer
      WHERE customer_full_name ILIKE '$1';
    `;
    const employeeQuery = `
      SELECT hotel_address, employee_ssn
      FROM Employee
      WHERE employee_full_name ILIKE '$1';
    `;

    const customerQueryParams = [`%${customer_full_name}%`];
    const employeeQueryParams = [`%${employee_full_name}%`];
    const { rows: customerRows } = await pool.query(customerQuery,customerQueryParams);
    const { rows: employeeRows } = await pool.query(employeeQuery, employeeQueryParams);

   
    const customer_ssn = customerRows[0].customer_ssn;
    const employee_ssn = employeeRows[0].employee_ssn;
    const hotel_address = employeeRows[0].hotel_address;
    // Construct the SQL query
    const query = `
    SELECT *
    FROM Renting
    JOIN Customer ON Renting.customer_ssn = Customer.customer_ssn
    WHERE Customer.customer_ssn = $1
    AND hotel_address ILIKE $2;
    AND employee_ssn = $3;
    `;

const queryParams = [
  customer_ssn,
  `%${hotel_address}%`,
  employee_ssn
];

    // Execute the SQL query
    const { rows } = await pool.query(query, queryParams);

    // Send the response with the fetched rooms
    res.json({ renting: rows });
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
      renting_end_date
    } = req.body;
    
    
    const rentingQuery = `
    INSERT INTO Renting (room_number, hotel_address, customer_ssn, employee_ssn, renting_start_date, renting_end_date)
    SELECT 
        $2, 
        $3, 
        (SELECT customer_ssn FROM Customer WHERE customer_full_name ILIKE $1), 
        (SELECT employee_ssn FROM Employee WHERE employee_full_name ILIKE $4), 
        $5, 
        $6
    RETURNING *;
    `;
    
    const { rows: rentingRows } = await pool.query(rentingQuery, [
      `%${customer_full_name}%`,
      room_number,
      `${hotel_address}`,
      `%${employee_full_name}%`,
      `${renting_start_date}`,
      `${renting_end_date}`
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
    const { customer_full_name, room_number, hotel_address, booking_start_date, booking_end_date } =
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
      INSERT INTO Booking (customer_ssn, room_number, hotel_address, booking_start_date, booking_end_date)
      VALUES ($1, $2, $3, $4,$5)
      RETURNING *;
    `;

    const { rows: bookingRows } = await pool.query(bookingQuery, [
      customer_ssn,
      room_number,
      hotel_address,
      booking_start_date,
      booking_end_date
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
app.get("/myHotel", async (req, res) => {
  try {
    // Extract parameters from the request
    const { employee_full_name } = req.query;

    // Construct the SQL query
    const query = `
      SELECT hotel_address
      FROM employee
      WHERE employee_full_name = $1
    `;

    const queryParams = ['employee_full_name'];

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
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
