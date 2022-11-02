import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/accounts/screens/account_screen.dart';
import 'package:td_shoping/features/cart/screen/cart_screen.dart';
import 'package:td_shoping/features/home/screens/home_screen.dart';
import 'package:td_shoping/provider/user_provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWith = 42;
  double bottomBarBorderWith = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // trang chủ
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWith,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWith,
                  ),
                ),
              ),
              child: Icon(
                Icons.home_outlined,
                color: _page == 0
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.unselectedNavBarColor,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWith,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWith,
                  ),
                ),
              ),
              child: Icon(
                Icons.person_outline,
                color: _page == 1
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.unselectedNavBarColor,
              ),
            ),
            label: "",
          ),
          // tài khoản
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWith,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWith,
                    ),
                  ),
                ),
                child: Badge(
                  elevation: 0,
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                    userCartLen.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  badgeColor: Colors.pink[400]!,
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.unselectedNavBarColor,
                  ),
                ),
              ),
              label: ""),
        ],
      ),
    );
  }
}
