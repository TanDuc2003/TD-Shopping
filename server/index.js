// Khai báo thư viện
const express = require("express");
const mongoose = require("mongoose");

// khai báo các folder khác
const adminRouter = require("./routes/admin");
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");
// khởi tạo
const PORT = 3000;
const app = express();
const DB =
  "mongodb+srv://nguy3ntanduc:nguy3ntanduc@cluster0.kwpcnfb.mongodb.net/?retryWrites=true&w=majority";

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
//CLIENT=> SERVER=>CLIENT
// GET,PUT,POST,DELETE ==> CRUD

//kết nối cơ sở dữ liệu
mongoose
  .connect(DB)
  .then(() => {
    console.log("kết nối DB thành công");
  })
  .catch((e) => {
    console.log("kết nối DB thất bại :" + e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log("kết nối thành công :" + PORT);
});
