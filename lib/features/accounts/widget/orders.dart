import 'package:flutter/widgets.dart';
import 'package:td_shoping/common/widgets/loadding.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/accounts/services/account_services.dart';
import 'package:td_shoping/features/accounts/widget/single_product.dart';
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
                  Container(
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
                ],
              ),
              //hiển thị đơn hàng
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: ((context, index) {
                    return SingleProduct(
                      image: orders![index].products[0].images[0],
                    );
                  }),
                ),
              ),
            ],
          );
  }
}
