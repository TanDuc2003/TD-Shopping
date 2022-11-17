import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:td_shoping/common/widgets/loadding.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/home/screens/all_product_screen.dart';
import 'package:td_shoping/features/home/services/home_services.dart';
import 'package:td_shoping/models/product.dart';

class CategoryDealScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();
  RefreshController refreshC = RefreshController();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  void refreshData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      fetchCategoryProducts();
      setState(() {});
      refreshC.refreshCompleted();
    } catch (e) {
      refreshC.refreshFailed();
    }
  }

  void loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      fetchCategoryProducts();
      setState(() {});
      refreshC.loadComplete();
    } catch (e) {
      refreshC.loadFailed();
    }
  }
  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
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
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Loading()
          : SmartRefresher(
              physics: const BouncingScrollPhysics(),
              controller: refreshC,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: refreshData,
              onLoading: loadData,
              header: const WaterDropHeader(
                waterDropColor: Colors.pink,
              ),
              footer: CustomFooter(
                builder: (context, mode) {
                  if (mode == LoadStatus.idle) {
                    return const SizedBox();
                  } else if (mode == LoadStatus.loading) {
                    return const Center(
                      child: SizedBox(
                        width: 100,
                        height: 50,
                        child: Loading2(),
                      ),
                    );
                  } else if (mode == LoadStatus.failed) {
                    return const Center(
                        child: Text("Tải thất bại! Click để tải lại !"));
                  } else if (mode == LoadStatus.canLoading) {
                    return const Center(
                        child: Text(
                      "Tải Thêm",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ));
                  } else {
                    return const Center(child: Text("Không thể tải dữ liệu"));
                  }
                },
              ),
              child: AllProductsScreen(product: productList!),
            ),
    );
  }
}
