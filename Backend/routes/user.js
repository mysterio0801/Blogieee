const { json } = require("express");
const express = require("express");
const User = require("../models/usermodel");
const config = require("../config");
const jwt = require("jsonwebtoken");
let middleware = require("../middleware");

const router = express.Router();

router.route("/:username").get(middleware.checkToken, (req, res) => {
  User.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    res.json({
      data: result,
      username: req.params.username,
    });
  });
});

router.route("/checkusername/:username").get((req, res) => {
  User.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result !== null) {
      return res.json({
        Status: true,
      });
    } else {
      return res.json({
        Status: false,
      });
    }
  });
});

router.route("/login").post((req, res) => {
  User.findOne({ username: req.body.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result === null) {
      return res.status(403).json("User not found");
    }
    if (result.password === req.body.password) {
      let token = jwt.sign({ username: req.body.username }, config.key, {
        expiresIn: "365d",
      });
      res.json({
        token: token,
        msg: "Success",
      });
    } else {
      res.status(403).json("Password is incorrect");
    }
  });
});

router.route("/register").post((req, res) => {
  console.log("Inside the register");
  const user = new User({
    username: req.body.username,
    email: req.body.email,
    password: req.body.password,
  });

  user
    .save()
    .then(() => {
      console.log("User Registered");
      res.status(200).json("ok");
    })
    .catch((err) => {
      res.status(403).json({ msg: err });
    });
});

router.route("/update/:username").patch(middleware.checkToken, (req, res) => {
  User.findOneAndUpdate(
    { username: req.params.username },
    { $set: { password: req.body.password } },
    (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      const msg = {
        msg: "Password successfully updated",
        username: req.params.username,
      };
      return res.json(msg);
    }
  );
});

router.route("/delete/:username").delete(middleware.checkToken, (req, res) => {
  User.findOneAndDelete({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    const msg = {
      msg: "User deleted successfully",
      username: req.params.username,
    };
    return res.json(msg);
  });
});

module.exports = router;
