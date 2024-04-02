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
    LEFT JOIN renting rent ON r.room_number = rent.room_number
        AND r.hotel_address = rent.hotel_address
        AND ((rent.renting_start_date BETWEEN $1 AND $2)
        OR (rent.renting_end_date BETWEEN $1 AND $2))
    WHERE r.capacity >= $3
    AND h.hotel_address ILIKE $4
    AND r.price <= $5
    AND rent.room_number IS NULL;
`;

    const queryParams = [
      `${startDate.trim()}`,
      `${endDate.trim()}`,
      parseInt(roomCapacity.trim()),
      `%${hotel_address.trim()}%`,
      parseInt(roomPrice.trim()),
    ];

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
    const { fullName } = req.query;
    
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
      customer_full_name
    } = req.query;
    
    // Construct the SQL query
    const query = `
    SELECT b.*
  FROM Booking b
  JOIN Customer c ON b.customer_ssn = c.customer_ssn
  WHERE c.customer_full_name ILIKE $1;
    `;

const queryParams = [
  `%${customer_full_name}%`
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
      customer_full_name,
      employee_full_name
    } = req.query;
    
    // Construct the SQL query
    const query = `
    SELECT r.*
  FROM Renting r
  JOIN Customer c ON r.customer_ssn = c.customer_ssn
  JOIN Employee e ON r.employee_ssn = e.employee_ssn
  WHERE c.customer_full_name = $1
  AND e.employee_full_name = $2;
    `;

const queryParams = [
  `%${customer_full_name}%`,
  `%${employee_full_name}%`
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
app.post("/bookingToRenting", async (req, res) => {
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


    const deletebookingQuery = `DELETE FROM Booking 
    WHERE customer_ssn = (SELECT customer_ssn FROM Customer WHERE customer_full_name ILIKE $1) 
    AND room_number = $2 AND hotel_address = $3 AND booking_start_date = $4 AND booking_end_date = $5;`;
    const { rows: bookingRows } = await pool.query(deletebookingQuery, [
      `%${customer_full_name}%`,
        room_number,
      `${hotel_address}`,
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
app.get("/bookingRentable", async (req, res) => {
  try {
    // Extract parameters from the request
    const { customer_full_name, booking_start_date, booking_end_date, room_number,
      hotel_address } = req.query;

    // Construct the SQL query
    const query = `
    SELECT EXISTS (
      SELECT 1
      FROM 
          Booking b
      INNER JOIN 
          Renting r ON b.room_number = r.room_number
                  AND b.hotel_address = r.hotel_address
                  AND (
                      (b.booking_start_date BETWEEN r.renting_start_date AND r.renting_end_date)
                      OR (b.booking_end_date BETWEEN r.renting_start_date AND r.renting_end_date)
                      OR (r.renting_start_date BETWEEN b.booking_start_date AND b.booking_end_date)
                      OR (r.renting_end_date BETWEEN b.booking_start_date AND b.booking_end_date)
                  )
      
 WHERE
          b.customer_ssn = (
              SELECT customer_ssn
              FROM Customer
              WHERE customer_full_name ILIKE $1
              LIMIT 1
          )
          AND b.room_number = $2
          AND b.hotel_address ILIKE $3
          AND b.booking_start_date = $4
          AND b.booking_end_date = $5
  ) AS conflict_exists;
    `;

    const queryParams = [
      `%${customer_full_name}%`,
      room_number,
      `%${hotel_address}%`,
      `${booking_start_date}`,
      `${booking_end_date}`
    ];

    // Execute the SQL query
    const { rows } = await pool.query(query, queryParams);
    if (rows[0].conflict_exists) {
      const deletebookingQuery = `DELETE FROM Booking 
    WHERE customer_ssn = (SELECT customer_ssn FROM Customer WHERE customer_full_name ILIKE $1) 
    AND room_number = $2 AND hotel_address = $3 AND booking_start_date = $4 AND booking_end_date = $5;`;
    const { rows: bookingRows } = await pool.query(deletebookingQuery, [
      `%${customer_full_name}%`,
        room_number,
      `${hotel_address}`,
      `${booking_start_date}`,
      `${booking_end_date}`
    ]);

    }
    // Send the response indicating rentability status
    res.json({ rentable: !rows[0].conflict_exists});
  } catch (error) {
    // Handle errors
    console.error("Error executing query:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});
app.get("/update", async (req, res) => {
  try {
    // Extract parameters from the request

    // Construct the SQL query
    const bookingUpdateQuery = `
    DELETE FROM Booking
    WHERE booking_end_date < CURRENT_DATE;
    `;
    const rentingUpdateQuery = `
    DELETE FROM Renting
    WHERE renting_end_date < CURRENT_DATE;
    `;



    // Execute the SQL query
    const { rows } = await pool.query(bookingUpdateQuery);
    const { rows: rows2 } = await pool.query(rentingUpdateQuery);

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
