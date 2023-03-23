import 'package:flutter/material.dart';
import 'package:td_shoping/common/widgets/custom_textfield_v2.dart';
import 'package:td_shoping/features/auth/services/auth_services.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
// các chức năng đăng nhập,đăng ký
  final _signUpFromKey = GlobalKey<FormState>();
  final AuthServices authServices = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void singUpUser() {
    authServices.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passController.text,
      name: _nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: Colors.grey[200],
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Divider(
                        height: 1,
                        endIndent: 20,
                        indent: 20,
                        color: Colors.black26,
                        thickness: 2,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(50)),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        radius: 40,
                        child: Text(
                          "TD",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Divider(
                        height: 1,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "WELCOME BACK",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 400),
                    child: Column(
                      children: [
                        Form(
                          key: _signUpFromKey,
                          child: Column(
                            children: [
                              CustomTextFielV2(
                                controller: _nameController,
                                hintText: "Họ Tên",
                                iconData: Icons.person,
                              ),
                              const SizedBox(height: 30),
                              CustomTextFielV2(
                                controller: _emailController,
                                hintText: "Gmail",
                                iconData: Icons.email,
                              ),
                              const SizedBox(height: 30),
                              CustomTextFielV2(
                                controller: _passController,
                                hintText: "Mật Khẩu",
                                iconData: Icons.password,
                                isShow: true,
                                isShowPass: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              if (_signUpFromKey.currentState!.validate()) {
                                singUpUser();
                              }
                            },
                            child: const Text(
                              "Đăng Ký",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Bạn đã có tài khoản ? ",
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(
                                context,
                              ),
                              child: const Text(
                                "Đăng Nhập",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
