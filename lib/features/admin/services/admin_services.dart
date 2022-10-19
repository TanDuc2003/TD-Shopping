// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:td_shoping/constants/error_handling.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/constants/utils.dart';
import 'package:td_shoping/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:td_shoping/provider/user_provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloundinary = CloudinaryPublic("dusljsoev", "shy4fwhi");
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloundinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
        Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price,
        );

        http.Response response = await http.post(
          Uri.parse('$uri/admin/add-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: product.toJson(),
        );

        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Thêm sản phẩm thành công ");
            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //lấy tất cả sản phẩm
  Future<List<Product>> fetchAllProduct(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
