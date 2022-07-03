// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose  = require("mongoose");

// IMPORTS FROM OTHER FILES
const authRouter = require('./routes/auth');

// INITS
const app = express();
const port = 3000;

// MIDDLEWARE
app.use(authRouter);

// CONNECTIONS
mongoose.connect().then(()=>{
    console.log("DB connection successfull");
}).catch((e)=>{
    console.log(`DB connection error: ${e}`);
});

app.get("/", (req, res) => res.json({ body: "Welcome!" }));
app.listen(port,  () =>
  console.log(`App listening on port ${port}!`)
);
