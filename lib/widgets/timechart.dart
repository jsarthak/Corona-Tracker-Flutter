import 'dart:math';

import 'package:corona_tracker/models/historical.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class TimeChart extends StatefulWidget {
  final double height;
  final List<charts.Series<HistoricalGlobalData, DateTime>> dataList;
  final String title;

  const TimeChart({Key key, this.height, this.dataList, this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TimeChartState();
  }
}

class TimeChartState extends State<TimeChart> {
  List<Widget> children;
  DateTime _time;
  Map<String, String> _measures;

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('dd MMM yyyy');
    children = [
      Container(
          padding: EdgeInsets.only(
            top: 16,
          ),
          child: Center(
              child: Text(widget.title,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
      Container(
          height: widget.height,
          padding: EdgeInsets.all(8),
          child: _buildTimeSeriesWidget())
    ];
    if (_time != null) {
      children.add(new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text(formatter.format(_time))));
    }
    _measures?.forEach((String series, String value) {
      children.add(new Text('${series}: ${value}'));
    });
    return Card(
      elevation: 8,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.only(bottom: 12),
          child: Column(children: children),
        ),
      ),
    );
  }

  onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    String time;
    final measures = <String, String>{};
    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.date;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        if (datumPair.series.displayName == 'Cases')
          measures[datumPair.series.displayName] = datumPair.datum.confimed;
        else if (datumPair.series.displayName == 'Deaths')
          measures[datumPair.series.displayName] = datumPair.datum.deaths;
        else if (datumPair.series.displayName == 'Recovered')
          measures[datumPair.series.displayName] = datumPair.datum.recovered;
      });
    }
    setState(() {
      _time = DateTime.parse(time);
      _measures = measures;
    });
  }

  Widget _buildTimeSeriesWidget() {
    return charts.TimeSeriesChart(
      widget.dataList,
      defaultInteractions: true,
      domainAxis: new charts.DateTimeAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 10, color: charts.MaterialPalette.white),
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.gray.shade700))),
      behaviors: [
        new charts.SeriesLegend(),
        new charts.PanAndZoomBehavior(),
      ],
      selectionModels: [
        new charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            changedListener: onSelectionChanged)
      ],
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickFormatterSpec:
              new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                  NumberFormat.compact()),
          renderSpec: new charts.GridlineRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 10, color: charts.MaterialPalette.white),
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.gray.shade700))),
      animate: false,
    );
  }
}
