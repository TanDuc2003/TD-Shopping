import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:td_shoping/features/admin/screens/addproduct_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  void navigateAddProduct() {
    Navigator.pushNamed(context, AddProducScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("product"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateAddProduct();
        },
        tooltip: 'Thêm sản phẩm',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
