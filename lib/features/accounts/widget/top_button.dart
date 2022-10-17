import 'package:flutter/widgets.dart';
import 'package:td_shoping/features/accounts/widget/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

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
              onTap: () {},
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
