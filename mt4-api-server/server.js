const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
const PORT = 6000;

// Middleware
app.use(bodyParser.json()); // Parse JSON request bodies
app.use(cors()); // Allow Cross-Origin Resource Sharing

// Routes
app.get("/", (req, res) => {
  res.send("MT4 API Server is running!");
});

// Endpoint to handle MT4 requests
app.post("/api/tradedata", (req, res) => {
  // Log incoming data
  console.log("Received data from MT4:", req.body);

  // Simulate processing the received data
  const { account, balance, equity } = req.body;
  if (!account || !balance || !equity) {
    return res.status(400).json({ message: "Invalid data received!" });
  }

  // Respond back to MT4
  res.status(200).json({
    message: "Data received successfully!",
    account: account,
    balance: balance,
    equity: equity,
  });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

