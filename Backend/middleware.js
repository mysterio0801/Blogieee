const jwt = require("jsonwebtoken");
const config = require("./config");

let checkToken = (req, res, next) => {
  let token = req.headers["authorization"];
  console.log(token);
  if (token) {
    token = token.slice(7, token.length);
    jwt.verify(token, config.key, (err, decoded) => {
      if (err) {
        console.log(err);
        return res.json({
          status: false,
          msg: err,
        });
      } else {
        req.decoded = decoded;
        next();
      }
    });
  } else {
    return res.json({
      status: false,
      msg: "Token is not provided",
    });
  }
};

module.exports = {
  checkToken: checkToken,
};
