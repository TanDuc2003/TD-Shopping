import 'package:flutter/material.dart';
import 'package:td_shoping/common/widgets/loadding.dart';
import 'package:td_shoping/features/accounts/widget/single_product.dart';
import 'package:td_shoping/features/admin/services/admin_services.dart';
import 'package:td_shoping/features/details_orders/screens/orders_details.dart';

import '../../../models/orders.dart';

class OrderScreens extends StatefulWidget {
  const OrderScreens({super.key});

  @override
  State<OrderScreens> createState() => _OrderScreensState();
}

class _OrderScreensState extends State<OrderScreens> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchAllOrderProduc();
  }

  void fetchAllOrderProduc() async {
    orders = await adminServices.fetchAllOrderProduct(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loading()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10, crossAxisCount: 2),
              itemCount: orders!.length,
              itemBuilder: (context, index) {
                final orderData = orders![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetailsScreen.routeName,
                      arguments: orderData,
                    );
                  },
                  child: SizedBox(
                    height: 140,
                    child: SingleProduct(
                      image: orderData.products[0].images[0],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
