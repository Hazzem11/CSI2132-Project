require('dotenv').config();

const Pool = require("pg").Pool;

const pool = new Pool({
   user: process.env.DB_USER,
   password: 'Fe25Zouz2004!',
   host: process.env.DB_HOST,
   port: process.env.DB_PORT,
   database: process.env.DB_NAME
});

module.exports = pool;