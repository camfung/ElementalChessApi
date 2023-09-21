const { Client } = require("pg");

async function executeQuery(sqlQuery) {
  const client = new Client({
    connectionString: connectionString,
    ssl: {
      rejectUnauthorized: false,
    },
  });

  try {
    await client.connect();
    const res = await client.query(sqlQuery);
    return res.rows;
  } catch (err) {
    throw new Error(`Database Error: ${err.message}`);
  } finally {
    await client.end();
  }
}

module.exports = {
  executeQuery,
};
