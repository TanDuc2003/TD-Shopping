import 'dart:async';

import 'package:flutter/material.dart';

class SpashScreen extends StatefulWidget {
  final Widget widget;
  const SpashScreen({Key? key, required this.widget}) : super(key: key);

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
      const Duration(milliseconds: 4000),
      () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => widget.widget,
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
        color: Colors.black,
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Image.asset(
              "assets/category/logo1.png",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
