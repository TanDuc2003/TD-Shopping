import 'package:flutter/material.dart';
import 'package:td_shoping/common/widgets/bottom_bar.dart';
import 'package:td_shoping/features/admin/screens/addproduct_screen.dart';
import 'package:td_shoping/features/auth/screens/auth_screen.dart';
import 'package:td_shoping/features/home/screens/home_screen.dart';

Route<dynamic> generateraRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (context) => const BottomBar(),
      );
    case AddProducScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AddProducScreen(),
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
