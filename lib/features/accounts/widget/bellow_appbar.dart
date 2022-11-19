import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/provider/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BellowAppBar extends StatelessWidget {
  const BellowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final Uri url = Uri.parse('https://www.messenger.com/t/2908504429249519/');
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                  color: Colors.orange,
                  child: Text(
                    user.name[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.amber[900],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      user.type == 'user' ? "Thành viên " : "Admin",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          right: 5,
          top: 0,
          child: IconButton(
            onPressed: () async {
              if (!await launchUrl(url)) {
                throw 'Could not launch $url';
              }
            },
            icon: const Icon(
              Icons.message_outlined,
              size: 33,
            ),
          ),
        )
      ],
    );
  }
}
