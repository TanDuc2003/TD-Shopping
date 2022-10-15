// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:td_shoping/common/widgets/custom_button.dart';
import 'package:td_shoping/common/widgets/custom_textfield.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/auth/services/auth_services.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFromKey = GlobalKey<FormState>();
  final _signInFromKey = GlobalKey<FormState>();
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
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welecom",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    "Tạo Tài Khoản",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signup,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      }),
                ),
                if (_auth == Auth.signup)
                  Container(
                    color: GlobalVariables.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _signUpFromKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              hintText: 'Họ và Tên',
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: _passController,
                              hintText: 'Mật Khẩu',
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                                onTap: () {
                                  //đăng ký
                                  if (_signUpFromKey.currentState!.validate()) {
                                    singUpUser();
                                  }
                                },
                                text: "Đăng Ký"),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    "Đăng Nhập Tài Khoản",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signin,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      }),
                ),
                if (_auth == Auth.signin)
                  Container(
                    color: GlobalVariables.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _signInFromKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: _passController,
                              hintText: 'Mật Khẩu',
                            ),
                            const SizedBox(height: 10),
                            CustomButton(onTap: () {}, text: "Đăng Nhập"),
                            const SizedBox(height: 10),
                          ],
                        ),
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
