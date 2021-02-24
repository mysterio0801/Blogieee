const { json } = require("express");
const express = require("express");
const User = require("../models/usermodel");

const router = express.Router();

router.route("/:username").get((req, res) => {
  User.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    res.json({
      data: result,
      username: req.params.username,
    });
  });
});

router.route("/login").post((req, res) => {
  User.findOne({ username: req.body.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result === null) {
      return res.status(403).json("User not found");
    }
    if (result.password === req.body.password) {
      res.json("token");
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

router.route("/update/:username").patch((req, res) => {
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

router.route("/delete/:username").delete((req, res) => {
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
