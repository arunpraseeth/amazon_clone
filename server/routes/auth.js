const e = require("express");
const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    // Get the data from client - email, password
    const { name, email, password } = req.body;

    // Checking email
    const existingUser = await User.findOne({ email });

    if (
      existingUser != null &&
      existingUser != undefined &&
      Object.keys(existingUser).length != 0
    ) {
      return res
        .status(400)
        .json({ msg: "User with same email already exist!" });
    }

    // Checking password
    var pass = req.body.password;
    if (pass.length < 6) {
      return res.status(400).json({ msg: "Password less than 6 characters!" });
    }

    // HASHING PASSWORD
    var hashedPassword = await bcryptjs.hash(pass, 8);

    // CREATING A USER MODEL (JUST LIKE IN DART), PUTTING ONLY THOSE REQUIRED.
    let user = User({
      name,
      email,
      password: hashedPassword,
    });
    user = await user.save();
    res.json(user);
    // Post data to database

    // Return some data to user
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
