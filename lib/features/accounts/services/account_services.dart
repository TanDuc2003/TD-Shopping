import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../provider/user_provider.dart';

class AccountServices {
  Future<List<Product>> fetchMyOrder({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/orders/me'), headers: {
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