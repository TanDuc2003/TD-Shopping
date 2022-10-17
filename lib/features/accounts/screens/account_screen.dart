// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/accounts/widget/bellow_appbar.dart';
import 'package:td_shoping/features/accounts/widget/orders.dart';
import 'package:td_shoping/features/accounts/widget/top_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/images/amazon_in.png",
                    width: 120,
                    height: 45,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 25,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          preferredSize: const Size.fromHeight(50)),
      body: Column(
        children: const [
          BellowAppBar(),
          SizedBox(height: 10),
          TopButtons(),
          SizedBox(height: 20),
          Orders(),
        ],
      ),
    );
  }
}
