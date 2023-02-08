import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:td_shoping/common/widgets/loadding.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/features/accounts/widget/single_product.dart';
import 'package:td_shoping/features/admin/screens/addproduct_screen.dart';
import 'package:td_shoping/features/admin/services/admin_services.dart';
import 'package:td_shoping/models/product.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  RefreshController refreshC = RefreshController();

  void refreshData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      fetchAllProducts();
      setState(() {});
      refreshC.refreshCompleted();
    } catch (e) {
      refreshC.refreshFailed();
    }
  }

  void loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      fetchAllProducts();
      setState(() {});
      refreshC.loadComplete();
    } catch (e) {
      refreshC.loadFailed();
    }
  }

  @override
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProduct(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateAddProduct() {
    Navigator.pushNamed(context, AddProducScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loading()
        : Scaffold(
            body: SmartRefresher(
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
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 2, right: 8, left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 130,
                          child: SingleProduct(
                            ishowStatus: true,
                            index: index,
                            image: productData.images.isEmpty
                                ? GlobalVariables.igError
                                : productData.images[0],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                productData.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                QuickAlert.show(
                                  context: context,
                                  title: "Bạn Có Muốn Xóa Sản Phẩm",
                                  type: QuickAlertType.error,
                                  text:
                                      'Sản phẩm khỏi danh mục buôn bán và không thể phục hồi !!',
                                  showCancelBtn: true,
                                  animType: QuickAlertAnimType.scale,
                                  onCancelBtnTap: () {
                                    deleteProduct(productData, index);
                                    Navigator.pop(context, 'Xóa');
                                  },
                                  confirmBtnText: 'Không',
                                  cancelBtnText: 'Có',
                                  confirmBtnColor: Colors.green,
                                );
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateAddProduct();
              },
              tooltip: 'Thêm sản phẩm',
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add, size: 30),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
