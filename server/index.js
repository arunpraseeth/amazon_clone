// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");

// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");

// INITS
const app = express();
const port = 3000;

const DB_CONNECTION =
  "mongodb+srv://praseeth:praseeth%40123@cluster0.ddh0y.mongodb.net/?retryWrites=true&w=majority";

// MIDDLEWARE
app.use(express.json());
app.use(authRouter);

// CONNECTIONS
mongoose
  .connect(DB_CONNECTION)
  .then(() => {
    console.log("DB connection successfull");
  })
  .catch((e) => {
    console.log(`DB connection error: ${e}`);
  });

app.get("/", (req, res) => res.json({ body: "Welcome!" }));
app.listen(port, "0.0.0.0", () =>
  console.log(`App listening on port ${port}!`)
);
