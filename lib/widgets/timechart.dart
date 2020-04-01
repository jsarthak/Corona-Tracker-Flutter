
import 'package:corona_tracker/models/historical.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class TimeChart extends StatefulWidget{
  final double height;
  final List<charts.Series<HistoricalGlobalData, DateTime>> dataList;
  final String title;

  const TimeChart({Key key, this.height, this.dataList, this.title}) : super(key: key);

  
  @override
  State<StatefulWidget> createState() {
    return _TimeChartState();
  }
}
class _TimeChartState extends State<TimeChart>{

  
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color:Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.only(bottom:12),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top:16,bottom: 8),
                child: Center(child: Text(widget.title,style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
              Container(
          height: widget.height,
                padding: EdgeInsets.all(8),
                
                child: charts.TimeSeriesChart(
                  widget.dataList,
                  behaviors: [
                    new charts.PanAndZoomBehavior(),
                  ],
                  domainAxis: new charts.DateTimeAxisSpec(
                      renderSpec: new charts.GridlineRendererSpec(
                          labelStyle: new charts.TextStyleSpec(
                              fontSize: 10, color: charts.MaterialPalette.white),
                          lineStyle: new charts.LineStyleSpec(
                              color: charts.MaterialPalette.gray.shade700))),
                  primaryMeasureAxis: new charts.NumericAxisSpec(
                     tickFormatterSpec: new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                      NumberFormat.compact()
                    ),
                      renderSpec: new charts.GridlineRendererSpec(
                          labelStyle: new charts.TextStyleSpec(
                              fontSize: 10, color: charts.MaterialPalette.white),
                          lineStyle: new charts.LineStyleSpec(
                              color: charts.MaterialPalette.gray.shade700))),
                  animate: false,
                ),
              ),
             
              
            ],
          ),
        ),
      ),
    );
  }
}

