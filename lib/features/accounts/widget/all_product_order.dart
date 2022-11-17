import 'package:flutter/material.dart';
import 'package:td_shoping/common/widgets/loadding.dart';
import 'package:td_shoping/features/accounts/widget/single_product.dart';
import 'package:td_shoping/models/orders.dart';

import '../../details_orders/screens/orders_details.dart';
import '../services/account_services.dart';

class AllProductsOrderScreen extends StatefulWidget {
  const AllProductsOrderScreen({super.key});

  @override
  State<AllProductsOrderScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsOrderScreen> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  double avgRating = 0;
  double myRating = 0;

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Trạng thái đơn hàng",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: orders == null
          ? const Loading()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 200,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                scrollDirection: Axis.vertical,
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
                      status: orders![index].status,
                    ),
                  );
                }),
              ),
            ),
    );
  }
}
