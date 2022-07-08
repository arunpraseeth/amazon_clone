const e = require("express");
const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/user");
const auth = require("../middleware/auth");

const authRouter = express.Router();

// SIGN UP
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
    if (password.length < 6) {
      return res.status(400).json({ msg: "Password less than 6 characters!" });
    }

    // HASHING PASSWORD
    var hashedPassword = await bcryptjs.hash(password, 8);

    // CREATING A USER MODEL (JUST LIKE IN DART), PUTTING ONLY THOSE REQUIRED.
    let user = User({
      name,
      email,
      password: hashedPassword,
    });

    // Post data to database
    user = await user.save();

    // Return some data to user
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// SIGN IN
authRouter.post("/api/signin", async (req, res) => {
  try {
    // Get the data from client - email, password
    const { email, password } = req.body;

    // Checking email
    const existingUser = await User.findOne({ email });

    if (existingUser == null) {
      return res.status(400).json({ msg: "User not found, kindly signup!" });
    }
    const existingUserPassword = existingUser.password;

    // Checking password
    if (password.length < 6) {
      return res.status(400).json({ msg: "Password less than 6 characters!" });
    }

    // CHECKING HASHED PASSWORD
    const comparePassword = await bcryptjs.compare(
      password,
      existingUserPassword
    );
    if (!comparePassword) {
      return res.status(400).json({ msg: "Incorrect password!" });
    }
    const token = jwt.sign({ id: existingUser._id }, "passwordKey");
    res.json({ token, ...existingUser._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("authToken");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) res.json(false);
    const user = await User.findById(verified.id);
    if (!user) res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// GET USER DATA

authRouter.get("/api/userdata", auth, async (req, res) => {
  const user = await User.findById(req.id);
  res.json({
    token: req.token,
    id: user.id,
    name: user.name,
    email: user.email,
    address: user.address,
  });
});

module.exports = authRouter;
