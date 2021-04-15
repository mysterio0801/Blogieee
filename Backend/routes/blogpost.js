const express = require("express");
const router = express.Router();
const BlogPost = require("../models/blogpostmodel");
const middleware = require("../middleware");

router.route("/add").post(middleware.checkToken, (req, res) => {
  const blogpost = BlogPost({
    username: req.decoded.username,
    title: req.body.title,
    about: req.body.about,
  });
  blogpost
    .save()
    .then((result) => {
      res.json({ data: result });
    })
    .catch((err) => {
      console.log(err), res.json({ err: err });
    });
});

module.exports = router;
