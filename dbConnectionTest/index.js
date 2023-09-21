// YourAzureFunction.js
const { executeQuery } = require("../utils/dbUtil");

module.exports = async function (context, req) {
  try {
    const query = "SELECT * FROM test_table where name = 'Jane'"; // Replace with your query
    const data = await executeQuery(query);

    context.res = {
      status: 200,
      body: data,
    };
  } catch (err) {
    context.res = {
      status: 500,
      body: err.message,
    };
  }
};
