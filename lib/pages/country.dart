
import 'package:corona_tracker/models/country.dart';
import 'package:corona_tracker/models/linscale.dart';
import 'package:corona_tracker/scoped_models/main.dart';
import 'package:corona_tracker/widgets/timechart.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/models/historical.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class CountryPage extends StatefulWidget {
  final MainModel model;
  final AffectedCountry affectedCountry;
  CountryPage(this.model, this.affectedCountry);
  
  @override
  State<StatefulWidget> createState() {
    return _CountryPageState();
  }
}

class _CountryPageState extends State<CountryPage> {
  @override
  void initState() {
    widget.model.fetchCountryHistoricalData(widget.affectedCountry.countryInfo.iso3);
    super.initState();
  }


  List<charts.Series<HistoricalGlobalData, DateTime>> _casesData() {
    return [
      new charts.Series(
          id: "Cases_C",
          data: widget.model.historicalCountryData,
          domainFn: (HistoricalGlobalData h, _) => DateTime.parse(h.date),
          measureFn: (HistoricalGlobalData h, _) => int.parse(h.confimed)),
    ];
  }

  List<charts.Series<HistoricalGlobalData, DateTime>> _deathsData() {
    return [
      new charts.Series(
          id: "Deaths_C",
          data: widget.model.historicalCountryData,
          domainFn: (HistoricalGlobalData h, _) => DateTime.parse(h.date),
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          measureFn: (HistoricalGlobalData h, _) => int.parse(h.deaths)),
    ];
  }
  List<charts.Series<HistoricalGlobalData, String>> _lastWeekData() {
int l = widget.model.historicalCountryData.length;
      List<HistoricalGlobalData> lastWeek = [];
      for (int i =0;i<7;i++){
             
 HistoricalGlobalData d1 = widget.model.historicalCountryData[l-1-i];
 HistoricalGlobalData d2 = widget.model.historicalCountryData[l-2-i];

        int n = int.parse(d1.confimed);
         int r = int.parse( d2.confimed);
                 int c =( n-r);

        HistoricalGlobalData d = HistoricalGlobalData(confimed:c.toString(),date: d1.date,recovered:d1.recovered,deaths: d1.deaths);
        
        lastWeek.add(d);

      }
      List<HistoricalGlobalData> lastWeek2= lastWeek.reversed.toList();
var formatter = new DateFormat('MMM dd');
    return [
      new charts.Series(
          id: "lastWeek_C",
          data: lastWeek2,
          domainFn: (HistoricalGlobalData h, _) =>formatter.format(DateTime.parse(h.date)),

          colorFn: (HistoricalGlobalData h,_)=>charts.MaterialPalette.blue.shadeDefault,
          measureFn: (HistoricalGlobalData h, _) =>int.parse(h.confimed)),
          
    
    ];
  }

  List<charts.Series<LinScale, String>> _pieData() {
    final data = [
      new LinScale(
          int.parse(widget.affectedCountry.active) -
             int.parse(widget.affectedCountry.critical) ,
          "Mild",
          charts.MaterialPalette.blue.shadeDefault),
      new LinScale(
          int.parse(widget.affectedCountry.recovered)  +
              int.parse(widget.affectedCountry.deaths) ,
          "Closed",
          charts.MaterialPalette.pink.shadeDefault),
      new LinScale(int.parse(widget.affectedCountry.active) , "Active",
          charts.MaterialPalette.purple.shadeDefault),
      new LinScale(int.parse(widget.affectedCountry.deaths) , "Deaths",
          charts.MaterialPalette.red.shadeDefault),
      new LinScale(int.parse(widget.affectedCountry.recovered), "Recovered",
          charts.MaterialPalette.green.shadeDefault),
      new LinScale(int.parse(widget.affectedCountry.critical) , "Serious",
          charts.MaterialPalette.yellow.shadeDefault),
    ];
    return [
      new charts.Series<LinScale, String>(
          data: data,
          id: "summary_c",
          measureFn: (LinScale numb, _) => numb.cases,
          domainFn: (LinScale n, _) => '${n.title}: ${(n.cases*100/int.parse(widget.affectedCountry.cases)).truncate()}%',
          colorFn: (LinScale n, _) => n.color,
          labelAccessorFn: (LinScale row, _) => '${row.cases}'),
    ];
  }

  List<charts.Series<HistoricalGlobalData, DateTime>> _recoveredData() {
    return [
      new charts.Series(
          id: "Recovered_C",
          data: widget.model.historicalCountryData,
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (HistoricalGlobalData h, _) => DateTime.parse(h.date),
          measureFn: (HistoricalGlobalData h, _) => int.parse(h.recovered)),
    ];
  }

  Widget pieChart() {
    return Card(
        elevation: 8,color:Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(12),
              child: Center(
                child: new charts.PieChart(_pieData(),
                animate: false,
                    behaviors: [
                      new charts.DatumLegend(
                          position: charts.BehaviorPosition.bottom,
                          desiredMaxRows: 3,

                          desiredMaxColumns: 2,
                          outsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                    ],
                    defaultRenderer:
                        new charts.ArcRendererConfig(
                          arcWidth: 70,
                          strokeWidthPx: 1,

                          arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                        labelPosition: charts.ArcLabelPosition.outside,


                        leaderLineColor: charts.MaterialPalette.white,
                        outsideLabelStyleSpec: charts.TextStyleSpec(
                            fontSize: 12, color: charts.MaterialPalette.white),
                      )
                    ])),
              ),
            )));
  }

  double chartHeight = 360;

Widget weekChart() {
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
                child: Center(child: Text("Past 7 days",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),

   
              Container(
                height: 240,
                padding: EdgeInsets.all(12),
                child: charts.BarChart(
                  _lastWeekData(),
                  animate: false,
                     domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(

              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 10, // size in Pts.
                  color: charts.MaterialPalette.white),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.gray.shade700))),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
        
         tickFormatterSpec: new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                      NumberFormat.compact()
                    ),
          renderSpec: new charts.GridlineRendererSpec(

              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 10, // size in Pts.
                  color: charts.MaterialPalette.white),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.gray.shade700))),
                      
                
                  defaultRenderer: charts.BarRendererConfig(

                    cornerStrategy: const charts.ConstCornerStrategy(16)),
                  

               
                )
              ),
              
            ],
          ),
        ),
      ),
    );
  }
  


  double cardHeight = 140;
    double borderRadius = 12;
  @override
  Widget build(BuildContext context) {
return ScopedModelDescendant<MainModel>(
  
      builder: (BuildContext context, Widget child, MainModel model) {   
        return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),onPressed: (){},)
        ],
        title: Text(widget.affectedCountry.country.toUpperCase()),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
Navigator.of(context).pop();
        },),
        
      ),
      body:  pageBody()
    );
      });
         
  }
  Widget pageBody(){
    if (widget.model.isLoadingCountryHistorical){
      return Container(
        color: Theme.of(context).primaryColorDark,
        child: Center(child: CircularProgressIndicator(),
      ));
    } else {
       return Center(
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),

        child: ListView(
                    padding: EdgeInsets.all(8),

          children: <Widget>[
            Row(children: [
              Expanded(
                flex: 1,
                child: Card(
                  color: Color.fromARGB(255, 58, 161, 197),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Container(
                      color: Colors.blue.shade600,
                      height: cardHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Infections",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.affectedCountry.cases.toString(),
                            style: TextStyle(fontSize: 28),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                             
                          Icon(
                             int.parse(widget.affectedCountry.todayCases)>0?Icons.trending_up:Icons.trending_down,
                            size: 18,
                          ),
                           SizedBox(
                            width: 8,
                          ),
                              Text(widget.affectedCountry.todayCases
                                  .toString() + ' Today'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                flex: 1,
                child: Card(
                  color: Color.fromARGB(255, 58, 161, 197),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Container(
                      color: Colors.red.shade800,
                      height: cardHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Deaths",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.affectedCountry.deaths.toString(),
                            style: TextStyle(fontSize: 28),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                       
                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                             
                          Icon(
                            int.parse(widget.affectedCountry.todayDeaths)>0?Icons.trending_up:Icons.trending_down,
                            size: 18,
                          ),
                           SizedBox(
                            width: 8,
                          ),
                              Text(widget.affectedCountry.todayDeaths
                                  .toString() + ' Today'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 8,
            ),
            Row(children: [
              Expanded(
                flex: 1,
                child: Card(
                  color: Color.fromARGB(255, 58, 161, 197),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Container(
                      color: Colors.green.shade600,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Recovered",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          
                          Text(
                            widget.affectedCountry.recovered,
                            style: TextStyle(fontSize: 28),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                flex: 1,
                child: Card(
                  color: Color.fromARGB(255, 58, 161, 197),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Container(
                      color: Colors.yellow.shade800,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Critical",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          
                         
                          Text(
                            widget.affectedCountry.critical.toString(),
                            style: TextStyle(fontSize: 28),
                          ),
                         
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 12,
            ),
            pieChart(),
            SizedBox(
              height: 12,
            ),
           weekChart(),
         
            SizedBox(
              height: 12,
            ),
            TimeChart(
              title : "Cases",
              dataList: _casesData(),
              height: 400,
            ),
            SizedBox(
              height: 12,
            ),
            TimeChart(
              title : "Deaths",
              dataList: _deathsData(),
              height: 400,
            ),
            SizedBox(
              height: 12,
            ),
            TimeChart(
              title : "Recovered",
              dataList: _recoveredData(),
              height: 400,
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
    }
    
   

  }
}
