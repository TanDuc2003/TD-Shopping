import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:td_shoping/common/widgets/loadding.dart';
import 'package:td_shoping/features/admin/model/sales.dart';
import 'package:td_shoping/features/admin/services/admin_services.dart';
import 'package:td_shoping/features/admin/widgets/category_product_charts.dart';

class AnalyticScreen extends StatefulWidget {
  const AnalyticScreen({super.key});

  @override
  State<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales, dienthoaiEarnings;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loading()
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "THỐNG KÊ DOANH SỐ",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      const Text(
                        'Tổng doanh thu : ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        NumberFormat.simpleCurrency(
                                locale: 'vi-VN', decimalDigits: 0)
                            .format(totalSales),
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 400,
                  child: CategoryProductCharts(
                    seriesList: [
                      charts.Series(
                        colorFn: (datum, index) =>
                            charts.MaterialPalette.red.shadeDefault,
                        areaColorFn: (datum, index) =>
                            charts.MaterialPalette.cyan.shadeDefault,
                        fillColorFn: (datum, index) =>
                            charts.MaterialPalette.red.shadeDefault,
                        id: 'Sales',
                        data: earnings!,
                        domainFn: (Sales sales, _) => sales.label,
                        overlaySeries: true,
                        measureFn: (Sales sales, _) => sales.earning,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }

}
