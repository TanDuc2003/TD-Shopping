import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:td_shoping/common/widgets/loadding.dart';
import 'package:td_shoping/features/accounts/widget/single_product.dart';
import 'package:td_shoping/features/admin/services/admin_services.dart';
import 'package:td_shoping/features/details_orders/screens/orders_details.dart';

import '../../../models/orders.dart';

class OrderScreens extends StatefulWidget {
  const OrderScreens({super.key});

  @override
  State<OrderScreens> createState() => _OrderScreensState();
}

class _OrderScreensState extends State<OrderScreens> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();
  RefreshController refreshC = RefreshController();
  @override
  void initState() {
    super.initState();
    fetchAllOrderProduc();

    Timer(
      const Duration(seconds: 20),
      () => fetchAllOrderProduc(),
    );
  }

  void refreshData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      fetchAllOrderProduc();
      setState(() {});
      refreshC.refreshCompleted();
    } catch (e) {
      refreshC.refreshFailed();
    }
  }

  void loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      fetchAllOrderProduc();
      setState(() {});
      refreshC.loadComplete();
    } catch (e) {
      refreshC.loadFailed();
    }
  }

  void fetchAllOrderProduc() async {
    orders = await adminServices.fetchAllOrderProduct(context);
    Timer(
      const Duration(seconds: 20),
      () => fetchAllOrderProduc(),
    );
    setState(() {});
  }

  void deleteProductOrder(Order productOrder, int index) async {
    adminServices.deleteProductOrder(
      context: context,
      productOrder: productOrder,
      onSuccess: () {
        orders!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loading()
        : Scaffold(
            body: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5),
                    child: SmartRefresher(
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
                                child:
                                    Text("T???i th???t b???i! Click ????? t???i l???i !"));
                          } else if (mode == LoadStatus.canLoading) {
                            return const Center(
                                child: Text(
                              "T???i Th??m",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ));
                          } else {
                            return const Center(
                                child: Text("Kh??ng th??? t???i d??? li???u"));
                          }
                        },
                      ),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                        ),
                        itemCount: orders!.length,
                        itemBuilder: (context, index) {
                          final orderData = orders![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                OrderDetailsScreen.routeName,
                                arguments: orderData,
                              );
                            },
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    SingleProduct(
                                      index: index,
                                      image: orderData.products[0].images[0],
                                    ),
                                    if (orderData.status == 0)
                                      const Text("??ang ????ng G??i",
                                          style: TextStyle(color: Colors.green))
                                    else if (orderData.status == 1)
                                      const Text("Shiper ???? L???y",
                                          style: TextStyle(color: Colors.green))
                                    else if (orderData.status == 2)
                                      const Text("??ang V???n Chuy???n",
                                          style: TextStyle(color: Colors.green))
                                    else if (orderData.status == 3)
                                      const Text(
                                        "Giao Th??nh C??ng",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                  ],
                                ),
                                if (orderData.status == 3)
                                  IconButton(
                                    onPressed: () {
                                      QuickAlert.show(
                                        context: context,
                                        title: "B???n C?? Mu???n X??a S???n Ph???m",
                                        type: QuickAlertType.error,
                                        text:
                                            'S???n ph???m kh???i danh m???c bu??n b??n v?? kh??ng th??? ph???c h???i !!',
                                        showCancelBtn: true,
                                        animType: QuickAlertAnimType.scale,
                                        onCancelBtnTap: () {
                                          deleteProductOrder(orderData, index);
                                          Navigator.pop(context, 'X??a');
                                        },
                                        confirmBtnText: 'Kh??ng',
                                        cancelBtnText: 'C??',
                                        confirmBtnColor: Colors.green,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
