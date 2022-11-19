import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../features/admin/screens/admin_screen.dart';
import '../../features/auth/screens/signIn_screen.dart';
import '../../provider/user_provider.dart';
import 'bottom_bar.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceInOut);
    _animationController.forward();
    Timer(
      const Duration(milliseconds: 2500),
      () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Provider.of<UserProvider>(context).user.token.isNotEmpty
                    ? Provider.of<UserProvider>(context).user.type == 'user'
                        ? const BottomBar()
                        : const AdminScreen()
                    : const LoginSceen(),
          ),
          (route) => false),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white24,
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.black,
                  highlightColor: Colors.orange,
                  child: Image.asset(
                    "assets/category/logo1.png",
                    color: Colors.black,
                  ),
                ),
                const Text(
                  "TDShopinG",
                  style: TextStyle(color: Colors.orange, fontSize: 22),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
