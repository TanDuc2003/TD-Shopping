import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td_shoping/common/widgets/bottom_bar.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/admin/screens/admin_screen.dart';
import 'package:td_shoping/features/auth/screens/auth_screen.dart';
import 'package:td_shoping/features/auth/services/auth_services.dart';
import 'package:td_shoping/provider/user_provider.dart';
import 'package:td_shoping/router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
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
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const ButtonBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}
