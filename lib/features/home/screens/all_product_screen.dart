import 'package:flutter/material.dart';
import 'package:td_shoping/common/widgets/loadding.dart';
import 'package:td_shoping/features/details_product/screens/products_details_screen.dart';
import 'package:td_shoping/features/home/widgets/single_product_home.dart';

import '../../../models/product.dart';

class AllProductsScreen extends StatefulWidget {
  final List<Product> product;
  const AllProductsScreen({super.key, required this.product});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  double avgRating = 0;
  double myRating = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.product.isEmpty
        ? const Loading2()
        : GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.product.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 270,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final productData = widget.product[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ProductDetailsScreen.routeName,
                    arguments: productData,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 2, right: 5, left: 5),
                  child: SingleProductHome(
                    image: productData.images[0],
                    name: productData.name,
                    price: productData.price,
                    product: productData,
                  ),
                ),
              );
            },
          );
  }
}
