import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:td_shoping/features/auth/components/animation/animation.dart';

import 'animation/heper_funcitions.dart';
import 'login_content.dart';

class TopText extends StatefulWidget {
  const TopText({Key? key}) : super(key: key);

  @override
  State<TopText> createState() => _TopTextState();
}

class _TopTextState extends State<TopText> {
  @override
  void initState() {
    ChangeScreenAnimation.topTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HelperFunctions.wrapWithAnimatedBuilder(
      animation: ChangeScreenAnimation.topTextAnimation,
      child: Shimmer.fromColors(
        baseColor: Colors.black,
        period: const Duration(milliseconds: 4000),
        direction: ChangeScreenAnimation.currentScreen == Screens.createAccount
            ? ShimmerDirection.ltr
            : ShimmerDirection.rtl,
        highlightColor: Colors.red,
        child: Text(
          ChangeScreenAnimation.currentScreen == Screens.createAccount
              ? 'Đăng Ký\n      Tài Khoản'
              : 'Welcome Back\n       Đăng Nhập',
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
