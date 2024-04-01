require('dotenv').config();

const Pool = require("pg").Pool;



const pool = new Pool({
   user: 'postgres',
   password: 'Mounir',
   host: 'localhost',
   port: 5432,
   database: 'eHotels'
});

module.exports = pool;
