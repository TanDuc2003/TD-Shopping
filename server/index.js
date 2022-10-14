// Khai báo thư viện
const express = require("express");
const mongoose = require("mongoose");

// khai báo cái folder khác
const authRouter = require("./routes/auth");
// khởi tạo
const PORT = 3000;
const app = express();

//middleware
app.use(authRouter);
//CLIENT=> SERVER=>CLIENT
// GET,PUT,POST,DELETE ==> CRUD

//kết nối cơ sở dữ liệu
mongoose
  .connect()
  .then(() => {
    console.log("kết nối DB thành công");
  })
  .catch((e) => {
    console.log("kết nối DB thất bại :" + e);
  });

app.listen(PORT, () => {
  console.log("kết nối thành công :" + PORT);
});
