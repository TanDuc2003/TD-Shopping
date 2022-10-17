const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res
        .status(401)
        .json({ msg: "Không có mã xác thực, quyền truy cập bị từ chối !" });
    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res.status(401).json({
        msg: "Sự thay đổi mã thông báo không thành công ủy quyền bị từ chối",
      });
    req.user = verified.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
module.exports = auth;
