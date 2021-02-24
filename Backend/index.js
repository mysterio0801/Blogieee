const express = require("express");
const mongoose = require("mongoose");
const app = express();
const port = process.env.port || 5000;

mongoose.connect("mongodb://localhost:27017/myapp", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  useCreateIndex: true,
});

const connection = mongoose.connection;
connection.once("open", () => {
  console.log("MongoDB Connected");
});

//middleware
app.use(express.json());
const userRoute = require("./routes/user");
app.use("/user", userRoute);

app.route("/").get((req, res) => res.json("Your first rest api"));

app.listen(port, () => console.log(`Your server is running on port ${port}`));
