import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td_shoping/common/widgets/splash_screen.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/constants/resets_app.dart';
import 'package:td_shoping/features/auth/services/auth_services.dart';
import 'package:td_shoping/provider/user_provider.dart';
import 'package:td_shoping/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const RestartWidget(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    authServices.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TdshopinG',
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
      home: const SpashScreen(),
    );
  }
}
