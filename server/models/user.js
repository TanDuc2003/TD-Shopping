const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  name: {
    // kiểu String, bắt buộc nhập, không được để trống
    require: true,
    type: String,
    trim: true,
  },
  email: {
    require: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Vui lòng nhập đúng định dạng Email",
    },
  },
  password: {
    require: true,
    type: String,
  },
  // có hai trường hợp người dùng chưa muốn cập nhật và đã cập nhập
  address: {
    type: String,
    default: " ",
  },
  //chọn đăng nhập dưới tư cách admin hay user
  type: {
    type: String,
    default: "user",
  },
  // giỏ hàngj
});

const User = mongoose.model("User", userSchema);
module.exports = User;
