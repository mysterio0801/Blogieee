const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const BlogPost = Schema({
  username: String,
  title: String,
  about: String,
  coverImage: {
    type: String,
    default: "",
  },
  share: Number,
  like: Number,
  comment: Number,
});

module.exports = mongoose.model("BlogPost", BlogPost);
