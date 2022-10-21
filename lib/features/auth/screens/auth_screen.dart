// ignore_for_file: unused_field
import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../components/center_widget/center_widget.dart';
import '../components/login_content.dart';

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
  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(0, 234, 244, 247),
              Color.fromARGB(179, 104, 67, 207),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Container(
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment(0.7, 0.8),
          colors: [
            Color.fromARGB(219, 235, 191, 232),
            Color.fromARGB(0, 168, 14, 65),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -160,
            left: -30,
            child: topWidget(screenSize.width),
          ),
          Positioned(
            bottom: -180,
            left: -40,
            child: bottomWidget(screenSize.width),
          ),
          CenterWidget(size: screenSize),
          const LoginContent(),
        ],
      ),
    );
  }
}

//  return Scaffold(
//       backgroundColor: GlobalVariables.greyBackgroundCOlor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Welecom",
//                   style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
//                 ),
//                 ListTile(
//                   tileColor: _auth == Auth.signup
//                       ? GlobalVariables.backgroundColor
//                       : GlobalVariables.greyBackgroundCOlor,
//                   title: const Text(
//                     "Tạo Tài Khoản",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   leading: Radio(
//                       activeColor: GlobalVariables.secondaryColor,
//                       value: Auth.signup,
//                       groupValue: _auth,
//                       onChanged: (Auth? val) {
//                         setState(() {
//                           _auth = val!;
//                         });
//                       }),
//                 ),
//                 if (_auth == Auth.signup)
//                   Container(
//                     color: GlobalVariables.backgroundColor,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Form(
//                         key: _signUpFromKey,
//                         child: Column(
//                           children: [
//                             CustomTextField(
//                               controller: _nameController,
//                               hintText: 'Họ và Tên',
//                             ),
//                             const SizedBox(height: 10),
//                             CustomTextField(
//                               controller: _emailController,
//                               hintText: 'Email',
//                             ),
//                             const SizedBox(height: 10),
//                             CustomTextField(
//                               controller: _passController,
//                               hintText: 'Mật Khẩu',
//                             ),
//                             const SizedBox(height: 10),
//                             CustomButton(
//                                 onTap: () {
//                                   //đăng ký
//                                   if (_signUpFromKey.currentState!.validate()) {
//                                     singUpUser();
//                                   }
//                                 },
//                                 text: "Đăng Ký"),
//                             const SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ListTile(
//                   tileColor: _auth == Auth.signin
//                       ? GlobalVariables.backgroundColor
//                       : GlobalVariables.greyBackgroundCOlor,
//                   title: const Text(
//                     "Đăng Nhập Tài Khoản",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   leading: Radio(
//                       activeColor: GlobalVariables.secondaryColor,
//                       value: Auth.signin,
//                       groupValue: _auth,
//                       onChanged: (Auth? val) {
//                         setState(() {
//                           _auth = val!;
//                         });
//                       }),
//                 ),
//                 if (_auth == Auth.signin)
//                   Container(
//                     color: GlobalVariables.backgroundColor,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Form(
//                         key: _signInFromKey,
//                         child: Column(
//                           children: [
//                             CustomTextField(
//                               controller: _emailController,
//                               hintText: 'Email',
//                             ),
//                             const SizedBox(height: 10),
//                             CustomTextField(
//                               controller: _passController,
//                               hintText: 'Mật Khẩu',
//                             ),
//                             const SizedBox(height: 10),
//                             CustomButton(
//                                 onTap: () {
//                                   //đăng nhập
//                                   if (_signInFromKey.currentState!.validate()) {
//                                     singIpUser();
//                                   }
//                                 },
//                                 text: "Đăng Nhập"),
//                             const SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
