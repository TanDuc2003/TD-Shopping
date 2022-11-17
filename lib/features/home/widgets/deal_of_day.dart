import 'package:flutter/material.dart';
import 'package:td_shoping/common/widgets/loadding.dart';
import 'package:td_shoping/features/details_product/screens/products_details_screen.dart';
import 'package:td_shoping/features/home/services/home_services.dart';
import 'package:td_shoping/models/product.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigaToDetailsScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailsScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loading()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigaToDetailsScreen,
                child: Container(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: const Text(
                          "Top Deal",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            product!.images[0],
                            fit: BoxFit.fitHeight,
                            width: double.infinity,
                            height: 200,
                          ),
                          Positioned(
                            bottom: -20,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: product!.images
                                    .map(
                                      (e) => Image.network(
                                        e,
                                        fit: BoxFit.fitWidth,
                                        width: 100,
                                        height: 100,
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 0.7),
                                        colorBlendMode: BlendMode.modulate,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 17,
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black45,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Row(
                                    children: const [
                                      Text("5"),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  "assets/category/sale.png",
                                  fit: BoxFit.cover,
                                  height: 50,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
  }
}
