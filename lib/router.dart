import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:td_shoping/features/auth/screens/auth_screen.dart';

Route<dynamic> generateraRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text("Màn hình hiển thị này không có !!"),
          ),
        ),
      );
  }
}
