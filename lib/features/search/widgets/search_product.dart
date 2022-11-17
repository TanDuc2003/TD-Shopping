import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:td_shoping/common/widgets/start.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/models/product.dart';

class SearchProduct extends StatelessWidget {
  final Product product;
  const SearchProduct({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    product.images.isEmpty
                        ? GlobalVariables.igError
                        : product.images[0],
                    fit: BoxFit.contain,
                    width: 120,
                    height: 120,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      SizedBox(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        width: 235,
                        child: Stars(rating: avgRating),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, bottom: 10),
                        child: Text(
                          NumberFormat.simpleCurrency(
                                  locale: 'vi-VN', decimalDigits: 0)
                              .format(product.price),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text(
                          "FreeShip trong vòng 10km",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          product.quantity != 0 ? "Còn Hàng" : "Hết Hàng",
                          style: TextStyle(
                            color: product.quantity != 0
                                ? Colors.teal
                                : Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
