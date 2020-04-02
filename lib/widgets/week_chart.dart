import 'package:corona_tracker/models/historical.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class WeekChart extends StatelessWidget {
  final List<charts.Series<HistoricalGlobalData, String>> data;

  const WeekChart({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.only(bottom: 12),
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Center(
                      child: Text("Past 7 days",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)))),
              Container(
                  height: 240,
                  padding: EdgeInsets.all(12),
                  child: charts.BarChart(
                    data,
                    defaultInteractions: false,
                    animate: false,
                    domainAxis: new charts.OrdinalAxisSpec(
                        renderSpec: new charts.SmallTickRendererSpec(
                            labelStyle: new charts.TextStyleSpec(
                                fontSize: 10, // size in Pts.
                                color: charts.MaterialPalette.white),
                            lineStyle: new charts.LineStyleSpec(
                                color: charts.MaterialPalette.gray.shade700))),
                    primaryMeasureAxis: new charts.NumericAxisSpec(
                        tickFormatterSpec: new charts
                                .BasicNumericTickFormatterSpec.fromNumberFormat(
                            NumberFormat.compact()),
                        renderSpec: new charts.GridlineRendererSpec(
                            labelStyle: new charts.TextStyleSpec(
                                fontSize: 10,
                                color: charts.MaterialPalette.white),
                            lineStyle: new charts.LineStyleSpec(
                                color: charts.MaterialPalette.gray.shade700))),
                    defaultRenderer: charts.BarRendererConfig(
                        cornerStrategy: const charts.ConstCornerStrategy(16)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
