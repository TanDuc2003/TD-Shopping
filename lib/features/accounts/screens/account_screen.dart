import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/accounts/screens/setting_screen.dart';
import 'package:td_shoping/features/accounts/widget/orders.dart';
import '../../cart/screen/cart_screen.dart';
import '../widget/bellow_appbar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void navigaToCartScreen(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        child: const CartScreen(),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const SettingScreen(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.settings_outlined,
                  size: 33,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () => navigaToCartScreen(context),
                icon: const Icon(
                  Icons.shopping_cart_checkout,
                  size: 33,
                ),
              ),
              const SizedBox(width: 10),
              badges.Badge(
                animationType: badges.BadgeAnimationType.scale,
                badgeContent: const Text(
                  "10",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                child: const Icon(
                  Icons.notifications_active_outlined,
                  size: 33,
                ),
              ),
            ],
          )),
      body: Column(
        children: const [
          BellowAppBar(),
          SizedBox(height: 30),
          SizedBox(height: 30),
          Orders(),
        ],
      ),
    );
  }
}
