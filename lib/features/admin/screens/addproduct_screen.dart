import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:td_shoping/common/widgets/custom_button.dart';
import 'package:td_shoping/common/widgets/custom_textfield.dart';
import 'package:td_shoping/constants/utils.dart';

import '../../../constants/global_variables.dart';

class AddProducScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProducScreen({super.key});

  @override
  State<AddProducScreen> createState() => _AddProducScreenState();
}

class _AddProducScreenState extends State<AddProducScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  String category = "Điện thoại";
  List<File> images = [];

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  List<String> productCategories = [
    "Điện thoại",
    "Đồ dùng thiết yếu",
    "Thiết bị gia dụng",
    "Thời trang",
    "Sách",
  ];

  void selectImage() async {
    var res = await pickImage();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            centerTitle: true,
            title: const Text(
              "Thêm Sản Phẩm",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((e) {
                          return Builder(
                            builder: (context) => Image.file(
                              e,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImage,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open_outlined,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Chọn ảnh Sản Phẩm',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: productNameController,
                  hintText: "Tên Sản Phẩm",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: descriptionController,
                  hintText: "Mô tả sản phẩm",
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: priceController,
                  hintText: "Giá Tiền Sản Phẩm",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: productNameController,
                  hintText: "Số Lượng",
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(onTap: () {}, text: "Bán"),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// 5:08:18 