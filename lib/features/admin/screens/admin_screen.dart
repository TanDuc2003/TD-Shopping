import 'package:flutter/material.dart';
import 'package:td_shoping/features/admin/screens/analytics_screen.dart';
import 'package:td_shoping/features/admin/screens/orders_screen.dart';
import 'package:td_shoping/features/admin/screens/post_screen.dart';
import '../../../constants/global_variables.dart';
import '../../accounts/services/account_services.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWith = 42;
  double bottomBarBorderWith = 5;
  final AccountServices accountServices = AccountServices();

  List<Widget> pages = [
    const PostScreen(),
    const AnalyticScreen(),
    const OrderScreens(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: const Text(
                  "Admin",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    // accountServices.logOut(context);
                    _showMyDialog();
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // trang ch???
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
                Icons.analytics_outlined,
                color: _page == 1
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.unselectedNavBarColor,
              ),
            ),
            label: "",
          ),
          // t??i kho???n
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
                child: Icon(
                  Icons.all_inbox_outlined,
                  color: _page == 2
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.unselectedNavBarColor,
                ),
              ),
              label: ""),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: Text(
              'B???n ch???c ch???n mu???n ????ng xu???t ?',
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 0.5),
                    ),
                    child: TextButton(
                      child: const Text(
                        'Kh??ng',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 0.5),
                    ),
                    child: TextButton(
                      child: const Text(
                        '?????ng ??',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        accountServices.logOut(context);
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
