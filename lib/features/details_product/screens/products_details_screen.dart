import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:td_shoping/features/cart/screen/cart_screen.dart';
import 'package:td_shoping/features/details_product/services/produc_details_services.dart';
import 'package:td_shoping/features/home/widgets/image_full_screen.dart';
import 'package:td_shoping/models/product.dart';
import 'package:td_shoping/provider/user_provider.dart';

import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = "/product-details";
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  int activeIndex = 0;
  double avgRating = 0;
  double myRating = 0;
  double rating = 0;
  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigatoCart() {
    Navigator.push(
      context,
      PageTransition(
        child: const CartScreen(),
        type: PageTransitionType.bottomToTop,
      ),
    );
  }

  void addToCart() {
    productDetailsServices.addToCart(
      context: context,
      product: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          color: Colors.white,
                          height: 340,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CarouselSlider(
                                items: widget.product.images.map((e) {
                                  return Builder(
                                    builder: (context) {
                                      return SizedBox(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                child:
                                                    ImageFullScreens(image: e),
                                                type: PageTransitionType.fade,
                                              ),
                                            );
                                          },
                                          child: Image.network(
                                            e,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  viewportFraction: 1,
                                  height: 350,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      activeIndex = index;
                                    });
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                child: buildIndicator(),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black.withOpacity(0.8),
                              size: 25,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  avgRating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      constraints: const BoxConstraints(minHeight: 350),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              widget.product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Giá :   ',
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: NumberFormat.simpleCurrency(
                                            locale: 'vi-VN', decimalDigits: 0)
                                        .format(widget.product.price),
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                " Còn ${widget.product.quantity.toInt()} sản phẩm",
                                style: TextStyle(
                                  color: widget.product.quantity != 0
                                      ? Colors.black38
                                      : Colors.purple,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ReadMoreText(
                                widget.product.description,
                                trimLines: 7,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: '  Chi tiết >',
                                trimExpandedText: '  Ẩn',
                                lessStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                                moreStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () async {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.custom,
                                  barrierDismissible: false,
                                  confirmBtnText: 'Save',
                                  showCancelBtn: true,
                                  confirmBtnColor: Colors.green,
                                  cancelBtnTextStyle: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                  cancelBtnText: 'Hủy',
                                  customAsset: 'assets/category/rating.gif',
                                  widget: Column(
                                    children: [
                                      const Text(
                                        "Đánh giá sản phẩm",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      RatingBar.builder(
                                        initialRating: myRating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: GlobalVariables.secondaryColor,
                                        ),
                                        onRatingUpdate: (value) {
                                          setState(() {
                                            rating = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  onConfirmBtnTap: () {
                                    productDetailsServices.rateProduct(
                                      context: context,
                                      product: widget.product,
                                      rating: rating,
                                    );
                                    Navigator.pop(context);
                                  },
                                  onCancelBtnTap: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              child: const Text(
                                'Đánh giá sản phẩm này ',
                                style: TextStyle(
                                  color: Colors.orange,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        splashColor: Colors.pinkAccent,
                        onTap: widget.product.quantity != 0
                            ? () {
                                addToCart();
                                navigatoCart();
                              }
                            : () {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: 'Oops...',
                                  text: 'Sorry, Sản phẩm này đã hết hàng',
                                  titleColor: Colors.red,
                                  textColor: Colors.black,
                                );
                              },
                        child: Container(
                          width: 80,
                          padding: const EdgeInsets.all(5),
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45, width: 2),
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            "assets/category/checkout.png",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          disabledBackgroundColor: Colors.black38,
                          disabledForegroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: widget.product.quantity != 0
                            ? () {
                                addToCart();
                                showSnackBar(
                                    context, "Đã thêm Sản Phẩm vào Giỏ hàng");
                              }
                            : null,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_shopping_cart_outlined,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              widget.product.quantity != 0
                                  ? "Thêm Vào Giỏ Hàng"
                                  : "Hết Hàng",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    widget.product.quantity != 0 ? 17 : 18,
                                color: widget.product.quantity != 0
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        effect: WormEffect(
          dotHeight: 10,
          dotWidth: 20,
          activeDotColor: Colors.red.withOpacity(1),
          dotColor: Colors.black38,
        ),
        count: widget.product.images.length,
      );
}
