import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/auth/screens/auth_screen.dart';
import 'package:td_shoping/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TMĐT',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateraRoute(settings),
      home: Scaffold(body: const AuthScreen()),
    );
  }
}
