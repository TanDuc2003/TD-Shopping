import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:td_shoping/common/widgets/loadding.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/accounts/services/account_services.dart';
import 'package:td_shoping/features/accounts/widget/all_product_order.dart';
import 'package:td_shoping/features/accounts/widget/single_product.dart';
import 'package:td_shoping/features/details_orders/screens/orders_details.dart';
import 'package:td_shoping/models/orders.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loading()
        : Column(
            children: [
              SizedBox(
                child: Text(
                  "Bạn đã đặt ${orders!.length} đơn hàng",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Đơn hàng của bạn ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const AllProductsOrderScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        "Tất cả",
                        style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //hiển thị đơn hàng
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetailsScreen.routeName,
                          arguments: orders![index],
                        );
                      },
                      child: SingleProduct(
                        image: orders![index].products[0].images[0],
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
  }
}
