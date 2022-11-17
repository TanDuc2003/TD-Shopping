import 'package:flutter/material.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/accounts/screens/account_screen.dart';
import 'package:td_shoping/features/home/screens/home_screen.dart';

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
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
