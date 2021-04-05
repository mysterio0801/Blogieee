const express = require("express");
const router = express.Router();
const Profile = require("../models/profilemodel");
const middleware = require("../middleware");
const multer = require("multer");
const path = require("path");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads");
  },
  filename: (req, file, cb) => {
    cb(null, req.decoded.username + ".jpg");
  },
});

const fileFilter = (req, file, cb) => {
  if (file.mimetype == "image/jpeg" || file.mimetype == "image/png") {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 6,
  },
  // fileFilter: fileFilter,
});

router
  .route("/add/image")
  .patch(middleware.checkToken, upload.single("img"), (req, res) => {
    Profile.findOneAndUpdate(
      { username: req.decoded.username },
      {
        $set: {
          img: req.file.path,
        },
      },
      { new: true },
      (err, profile) => {
        if (err) return res.status(500).send(err);
        const response = {
          message: "Image added successfully",
          data: profile,
        };
        return res.status(200).send(response);
      }
    );
  });

router.route("/add").post(middleware.checkToken, (req, res) => {
  const profile = Profile({
    username: req.decoded.username,
    name: req.body.name,
    profession: req.body.profession,
    DOB: req.body.DOB,
    titleline: req.body.titleline,
    about: req.body.about,
  });
  profile
    .save()
    .then(() => {
      return res.json({ msg: "Profile Successfully Stored" });
    })
    .catch((err) => {
      return res.status(400).json({ err: err });
    });
});

router.route("/checkProfile").get(middleware.checkToken, (req, res) => {
  Profile.findOne({ username: req.decoded.username })
    .then((result) => {
      if (result) {
        console.log(`Successfully found document: ${result}.`);
        return res.json({ status: true, result: result });
      } else {
        console.log("No document matches the provided query.");
        return res.json({ status: false });
      }
    })
    .catch((err) => {
      console.log(`Failed to find document: ${err}`);
      return res.json({ err: err });
    });
});

router.route("/getData").get(middleware.checkToken, (req, res) => {
  Profile.findOne({ username: req.decoded.username })
    .then((result) => {
      if (result) {
        return res.json({ status: true, data: result });
      } else {
        return res.json({ status: false, data: [] });
      }
    })
    .catch((err) => {
      return res.json({ err: err });
    });
});

router
  .route("/updateProfile")
  .patch(middleware.checkToken, async (req, res) => {
    let profile = {};
    await Profile.findOne({ username: req.decoded.username }, (err, result) => {
      if (err) {
        profile = {};
      }
      if (result != null) {
        profile = result;
      }
    });
    Profile.findOneAndUpdate(
      { username: req.decoded.username },
      {
        $set: {
          name: req.body.name ? req.body.name : profile.name,
          profession: req.body.profession
            ? req.body.profession
            : profile.profession,
          DOB: req.body.DOB ? req.body.DOB : profile.DOB,
          titleline: req.body.titleline
            ? req.body.titleline
            : profile.titleline,
          about: req.body.about ? req.body.about : profile.about,
        },
      }
    )
      .then((result) => {
        if (result) {
          return res.json({ status: true });
        } else {
          return res.json({ status: false });
        }
      })
      .catch((err) => {
        return res.json({ err: err });
      });
  });

module.exports = router;
