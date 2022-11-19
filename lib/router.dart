import 'package:flutter/material.dart';
import 'package:td_shoping/common/widgets/bottom_bar.dart';
import 'package:td_shoping/features/address/screen/address_screen.dart';
import 'package:td_shoping/features/admin/screens/addproduct_screen.dart';
import 'package:td_shoping/features/auth/screens/signIn_screen.dart';
import 'package:td_shoping/features/auth/screens/signUp_screen.dart';
import 'package:td_shoping/features/details_orders/screens/orders_details.dart';
import 'package:td_shoping/features/details_product/screens/products_details_screen.dart';
import 'package:td_shoping/features/home/screens/category_deal_screen.dart';
import 'package:td_shoping/features/home/screens/home_screen.dart';
import 'package:td_shoping/features/search/screens/search_screen.dart';
import 'package:td_shoping/models/orders.dart';
import 'package:td_shoping/models/product.dart';

Route<dynamic> generateraRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginSceen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginSceen(),
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
  
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProducScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProducScreen(),
      );
    case CategoryDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmout: totalAmount,
        ),
      );
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailsScreen(order: order),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Màn hình hiển thị này không có !!"),
          ),
        ),
      );
  }
}
