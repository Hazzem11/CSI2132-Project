require('dotenv').config();

const Pool = require("pg").Pool;

const pool = new Pool({
   user: 'postgres',
   password: 'Fe25Zouz2004!',
   host: 'localhost',
   port: 5432,
   database: 'ehotels'
});

module.exports = pool;