const express = require("express");
const mongoose = require("mongoose");
const app = express();
const port = process.env.PORT || 5000;

mongoose.connect(
  "mongodb+srv://mysterio_08:Mysterio0801@cluster0.k46pc.mongodb.net/myapp?retryWrites=true&w=majority",
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
  }
);

const connection = mongoose.connection;
connection.once("open", () => {
  console.log("MongoDB Connected");
});

//middleware
app.use(express.json());
const userRoute = require("./routes/user");
app.use("/user", userRoute);
const profileRoute = require("./routes/profile");
app.use("/profile", profileRoute);

app.route("/").get((req, res) => res.json("Your first rest api"));

app.listen(port, () => console.log(`Your server is running on port ${port}`));
