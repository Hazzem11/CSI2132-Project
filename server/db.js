const Pool = require("pg").Pool;

const pool = new Pool({
   user: "postgres",
   password: "KrmEmn_11",
   host: "localhost",
   port: 5432,
   database: "ehotels"
});

module.exports = pool;