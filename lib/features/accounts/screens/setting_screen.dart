import 'package:flutter/material.dart';
import 'package:td_shoping/features/accounts/services/account_services.dart';
import 'package:td_shoping/features/accounts/widget/elevebutton_setting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final AccountServices accountServices = AccountServices();

  //đăng xuất
  void logOut() {
    accountServices.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[200],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(
                "Tài khoản",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevaButtonSetting(
              onpress: () {},
              title: "Hồ sơ của tôi",
            ),
            ElevaButtonSetting(
              onpress: () {},
              title: "Địa chỉ",
            ),
            ElevaButtonSetting(
              onpress: () {},
              title: "Tài khoản/thẻ ngân hàng",
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(
                "Hỗ trợ",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevaButtonSetting(
              onpress: () {},
              title: "Mẹo và thủ thuật",
            ),
            ElevaButtonSetting(
              onpress: () {},
              title: "Tiêu chuẩn cộng đồng",
            ),
            ElevaButtonSetting(
              onpress: () {},
              title: "Giới Thiệu",
            ),
            ElevaButtonSetting(
              onpress: () {},
              title: "Yêu cầu xóa tài khoản",
            ),
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 1),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _showMyDialog(),
                style: ElevatedButton.styleFrom(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.black),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Đăng Xuất",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: Text(
              'Bạn chắc chắn muốn đăng xuất ?',
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 0.5),
                    ),
                    child: TextButton(
                      child: const Text(
                        'Không',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 0.5),
                    ),
                    child: TextButton(
                      child: const Text(
                        'Đồng ý',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        logOut();
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
