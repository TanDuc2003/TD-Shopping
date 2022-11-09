import 'package:flutter/widgets.dart';
import 'package:td_shoping/features/accounts/services/account_services.dart';
import 'package:td_shoping/features/accounts/widget/account_button.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final AccountServices accountServices = AccountServices();
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              onTap: () {},
              text: "Giỏ hàng",
            ),
            AccountButton(
              onTap: () {},
              text: "Bán Hàng",
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              onTap: () {
                accountServices.logOut(context);
              },
              text: "Đăng Xuất",
            ),
            AccountButton(
              onTap: () {},
              text: "Yêu Thích",
            ),
          ],
        )
      ],
    );
  }
}
