import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:td_shoping/features/admin/model/sales.dart';

class CategoryProductCharts extends StatelessWidget {
  final List<chart.Series<Sales, String>> seriesList;
  const CategoryProductCharts({super.key, required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return chart.BarChart(
      seriesList,
      animate: true,
    );
  }
}
