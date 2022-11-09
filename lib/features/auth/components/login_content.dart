import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:td_shoping/common/widgets/custom_botton_v2.dart';
import 'package:td_shoping/common/widgets/custom_textfield_v2.dart';
import 'package:td_shoping/features/auth/components/animation/animation.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/auth/services/auth_services.dart';

import 'animation/heper_funcitions.dart';
import 'bottom_text.dart';
import 'top_text.dart';

enum Screens {
  welcomeBack,
  createAccount,
}

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  late final List<Widget> createAccountContent;
  late final List<Widget> loginContent;

// các chức năng đăng nhập,đăng ký
  final _signUpFromKey = GlobalKey<FormState>();
  final _signInFromKey = GlobalKey<FormState>();
  final AuthServices authServices = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    ChangeScreenAnimation.dispose();
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

  void singInUser() {
    authServices.signInUser(
      context: context,
      email: _emailController.text,
      password: _passController.text,
    );
  }

  Widget orDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: GlobalVariables.kPrimaryColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'or',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: GlobalVariables.kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget logos() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/facebook.png'),
          const SizedBox(width: 24),
          Image.asset('assets/images/google.png'),
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: TextButton(
        onPressed: () {
        },
        child: const Text(
          'Quên mật khẩu ?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: GlobalVariables.kSecondaryColor,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    createAccountContent = [
      Form(
        key: _signUpFromKey,
        child: Column(
          children: [
            CustomTextFielV2(
                controller: _nameController,
                hintText: 'Họ Tên',
                iconData: Ionicons.person_outline),
            CustomTextFielV2(
                controller: _emailController,
                hintText: 'Email',
                iconData: Ionicons.mail_outline),
            CustomTextFielV2(
                controller: _passController,
                hintText: 'Mật Khẩu',
                isShowPass: true,
                isShow: true,
                iconData: Ionicons.lock_closed_outline),
          ],
        ),
      ),
      CustomButtonV2(
          onTap: () {
            if (_signUpFromKey.currentState!.validate()) {
              singUpUser();
            }
          },
          text: "Đăng Ký"),
      orDivider(),
      logos(),
    ];

    loginContent = [
      Form(
        key: _signInFromKey,
        child: Column(
          children: [
            CustomTextFielV2(
                controller: _emailController,
                hintText: 'Email',
                iconData: Ionicons.mail_outline),
            CustomTextFielV2(
                controller: _passController,
                hintText: 'Mật Khẩu',
                isShowPass: true,
                isShow: true,
                iconData: Ionicons.lock_closed_outline),
          ],
        ),
      ),
      CustomButtonV2(
          onTap: () {
            if (_signInFromKey.currentState!.validate()) {
              singInUser();
            }
          },
          text: "Đăng Nhập"),
      forgotPassword(),
    ];

    ChangeScreenAnimation.initialize(
      vsync: this,
      createAccountItems: createAccountContent.length,
      loginItems: loginContent.length,
    );

    for (var i = 0; i < createAccountContent.length; i++) {
      createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.createAccountAnimations[i],
        child: createAccountContent[i],
      );
    }

    for (var i = 0; i < loginContent.length; i++) {
      loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.loginAnimations[i],
        child: loginContent[i],
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 136,
          left: 24,
          child: TopText(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: createAccountContent,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: loginContent,
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: BottomText(),
          ),
        ),
      ],
    );
  }
}
