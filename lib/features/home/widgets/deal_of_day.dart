import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            "Ưu dãi trong ngày",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        Image.network(
          "https://macone.vn/wp-content/uploads/2020/11/macbook-pro-spacegray-m1-2020.jpeg",
          fit: BoxFit.fitHeight,
          height: 235,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15),
          alignment: Alignment.topLeft,
          child: const Text(
            "₫79.000",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            "MacBook Pro 2020 13 inch (MYD92/MYDC2) Apple M1 8GB RAM 512GB SSD – Like New",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                "https://macone.vn/wp-content/uploads/2018/11/MacBook-Pro-1322-M1.jpg",
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                "https://macone.vn/wp-content/uploads/2018/11/MacBook-Pro-1322-M1.jpg",
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                "https://macone.vn/wp-content/uploads/2018/11/MacBook-Pro-1322-M1.jpg",
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                "https://macone.vn/wp-content/uploads/2018/11/MacBook-Pro-1322-M1.jpg",
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                "https://macone.vn/wp-content/uploads/2018/11/MacBook-Pro-1322-M1.jpg",
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                "https://macone.vn/wp-content/uploads/2018/11/MacBook-Pro-1322-M1.jpg",
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            "Xem tất cả dell",
            style: TextStyle(
              color: Colors.cyan[800],
            ),
          ),
        )
      ],
    );
  }
}
