import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:td_shoping/features/admin/model/sales.dart';

class CategoryProductCharts extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;
  const CategoryProductCharts({super.key, required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 40,
          labelStyle: charts.TextStyleSpec(
            fontSize: 12,
            lineHeight: 3,
            color: charts.MaterialPalette.black,
          ),
          lineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
              labelStyle: charts.TextStyleSpec(
                  fontSize: 10, color: charts.MaterialPalette.black),
              lineStyle:
                  charts.LineStyleSpec(color: charts.MaterialPalette.black))),
      seriesList,
      animate: true,
    );
  }
}
