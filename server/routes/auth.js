const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existtingUser = await User.findOne({ email }); //kiểm tra email đã tồn tại hay chưas
    if (existtingUser) {
      return res.status(400).json({ msg: "Đã có người sử dụng email này !" });
    }

    //mã hóa password
    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
module.exports = authRouter;
