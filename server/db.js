require('dotenv').config();

const Pool = require("pg").Pool;

// const pool = new Pool({
//    user: process.env.DB_USER,
//    password: process.env.DB_PASSWORD,
//    host: process.env.DB_HOST,
//    port: process.env.DB_PORT,
//    database: process.env.DB_NAME
// });

const pool = new Pool({
   user: "postgres",
   password: "Fe25Zouz2004!",
   host: "localhost",
   port: "5432",
   database: "ehotels"
});

module.exports = pool;
