const express = require("express");

const authRouter = express.Router();

authRouter.post("/api/signup", (req, res) => {
  console.log(req.body);
  const{name,email,password}=req.body;

  //lấy dữ liệu từ người dùng
  //gửi dữ liệu dó lên database
  //trả lại dữ liệu đó để sử dụng
//nguyen tan duc
});
//1h28
module.exports = authRouter;
