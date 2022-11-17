import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shimmer/shimmer.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/address/screen/address_screen.dart';
import 'package:td_shoping/features/cart/widget/cart_product.dart';
import 'package:td_shoping/features/cart/widget/cart_subtotal.dart';
import 'package:td_shoping/features/home/widgets/address_box.dart';
import 'package:td_shoping/provider/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Uri _url =
      Uri.parse('https://www.facebook.com/profile.php?id=100007570936511');

  void navigateToAddressScreen(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Giỏ hàng",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () => _launchUrl(),
                child: Shimmer.fromColors(
                  baseColor: Colors.black54,
                  highlightColor: Colors.black,
                  direction: ShimmerDirection.rtl,
                  period: const Duration(milliseconds: 3000),
                  child: Image.asset(
                    "assets/category/logo.png",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            SizedBox(
              height: 440,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: user.cart.length,
                itemBuilder: (context, index) {
                  return CartProduct(index: index);
                },
              ),
            ),
            const CartSubtotal(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: 60,
        child: SizedBox(
          child: ElevatedButton(
            onPressed: () {
              user.cart.isEmpty
                  ? QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      title: 'Oops...',
                      text: 'Bạn chưa thêm bất kì sản phẩm nào vào giỏ hàng ',
                      confirmBtnColor: Colors.red,
                      titleColor: Colors.cyan,
                    )
                  : navigateToAddressScreen(sum);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Thanh Toán",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
