const { Client } = require("pg");

const connectionString =
  "postgres://elementalchess.app:ASRv1EZ7awmO@ep-mute-moon-98120910.us-east-2.aws.neon.tech/neondb";

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
