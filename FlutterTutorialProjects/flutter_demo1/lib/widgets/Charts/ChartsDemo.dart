import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartsDemo extends StatefulWidget {
  //
  ChartsDemo() : super();

  final String title = "Charts Demo";

  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  //

  List<charts.Series> seriesList;
  bool animate;

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
    animate = true;
  }

  /// Create random data.
  static List<charts.Series<Sales, String>> _createStackedRandomData() {
    final random = new Random();

    final desktopSalesData = [
      new Sales('2014', random.nextInt(100)),
      new Sales('2015', random.nextInt(100)),
      new Sales('2016', random.nextInt(100)),
      new Sales('2017', random.nextInt(100)),
    ];

    final tableSalesData = [
      new Sales('2014', random.nextInt(100)),
      new Sales('2015', random.nextInt(100)),
      new Sales('2016', random.nextInt(100)),
      new Sales('2017', random.nextInt(100)),
    ];

    final mobileSalesData = [
      new Sales('2014', random.nextInt(100)),
      new Sales('2015', random.nextInt(100)),
      new Sales('2016', random.nextInt(100)),
      new Sales('2017', random.nextInt(100)),
    ];

    return [
      new charts.Series<Sales, String>(
        id: 'Desktop',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<Sales, String>(
        id: 'Tablet',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<Sales, String>(
        id: 'Mobile',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }

  // Create random data.
  static List<charts.Series<Sales, String>> _createRandomData() {
    //
    final random = new Random();

    final data = [
      new Sales('2014', random.nextInt(100)),
      new Sales('2015', random.nextInt(100)),
      new Sales('2016', random.nextInt(100)),
      new Sales('2017', random.nextInt(100)),
      new Sales('2018', random.nextInt(100)),
    ];

    return [
      new charts.Series<Sales, String>(
        id: 'Sales',
        //colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: data,
        fillColorFn: (Sales sales, _) {
          return (sales.year == '2015')
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.green.shadeDefault;
        },
        insideLabelStyleAccessorFn: (Sales sales, _) {
          final color = (sales.year == '2014')
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.yellow.shadeDefault.darker;
          return new charts.TextStyleSpec(color: color);
        },
        // outsideLabelStyleAccessorFn: (Sales sales, _) {
        //   final color = (sales.year == '2015')
        //       ? charts.MaterialPalette.red.shadeDefault
        //       : charts.MaterialPalette.yellow.shadeDefault.darker;
        //   return new charts.TextStyleSpec(color: color);
        // },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: barChart(),
      ),
    );
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: animate,
      //barGroupingType: charts.BarGroupingType.stacked,
      // defaultRenderer: new charts.BarRendererConfig(
      //   cornerStrategy: const charts.ConstCornerStrategy(30),
      // ),
      defaultRenderer: new charts.BarRendererConfig(
          groupingType: charts.BarGroupingType.stacked, strokeWidthPx: 2.0),
      // defaultRenderer: new charts.BarRendererConfig(
      //     groupingType: charts.BarGroupingType.grouped, strokeWidthPx: 2.0),
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      // domainAxis: new charts.OrdinalAxisSpec(
      //   renderSpec: new charts.NoneRenderSpec(),
      // ),
    );
  }
}

/// Sample ordinal data type.
class Sales {
  final String year;
  final int sales;

  Sales(this.year, this.sales);
}
