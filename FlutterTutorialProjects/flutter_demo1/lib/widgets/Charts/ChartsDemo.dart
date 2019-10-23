import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartsDemo extends StatefulWidget {
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
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: data,
        fillColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        displayName: 'test',
        labelAccessorFn: (Sales sales, _) => '${sales.sales.toString()}',
        insideLabelStyleAccessorFn: (Sales sales, _) {
          final color = (sales.year == '2014')
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.yellow.shadeDefault.darker;
          return new charts.TextStyleSpec(color: color);
        },
        outsideLabelStyleAccessorFn: (Sales sales, _) {
          final color = (sales.year == '2014')
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.yellow.shadeDefault.darker;
          return new charts.TextStyleSpec(color: color);
        },
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
      //barRendererDecorator: new charts.BarLabelDecorator<String>(),
      //domainAxis: new charts.OrdinalAxisSpec(),
      defaultRenderer: new charts.BarRendererConfig(
        cornerStrategy: const charts.ConstCornerStrategy(30),
      ),
      // defaultRenderer: new charts.BarRendererConfig(
      //     groupingType: charts.BarGroupingType.grouped, strokeWidthPx: 2.0),
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );
  }
}

/// Sample ordinal data type.
class Sales {
  final String year;
  final int sales;

  Sales(this.year, this.sales);
}
