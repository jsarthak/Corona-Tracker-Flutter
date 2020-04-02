import 'package:corona_tracker/models/linscale.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChartData extends StatelessWidget {
  final List<charts.Series<LinScale, String>> dataList;

  const PieChartData({Key key, this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 420,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(32),
              child: Center(
                child: new charts.PieChart(dataList,
                    animate: false,
                    defaultInteractions: false,
                    selectionModels: [],
                    behaviors: [
                      new charts.DatumLegend(
                          position: charts.BehaviorPosition.bottom,
                          desiredMaxRows: 3,
                          desiredMaxColumns: 2,
                          cellPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          outsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 75,
                        strokeWidthPx: 1,
                        arcRendererDecorators: [
                          charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.auto,
                            leaderLineColor: charts.MaterialPalette.white,
                            outsideLabelStyleSpec: charts.TextStyleSpec(
                                fontSize: 12,
                                color: charts.MaterialPalette.white),
                            insideLabelStyleSpec: charts.TextStyleSpec(
                                fontSize: 12,
                                color: charts.MaterialPalette.white),
                          )
                        ])),
              ),
            )));
  }
}
