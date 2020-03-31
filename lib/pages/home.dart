import 'package:cached_network_image/cached_network_image.dart';
import 'package:corona_tracker/models/historical.dart';
import 'package:corona_tracker/pages/country.dart';
import 'package:corona_tracker/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  final MainModel model;
  HomePage({this.model});
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColorDark,
          bottomSheet: SolidBottomSheet(
            elevation: 8.0,

            toggleVisibilityOnTap: true,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            headerBar: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              height: 54,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text("Affected Countries",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                        flex: 0,
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.arrow_drop_up)))
                  ],
                ),
              ),
            ),
            body: _getUpperLayer(),
          ),
          drawer: Container(
            color: Theme.of(context).primaryColorDark,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Drawer(
              elevation: 8.0,
              child: Container(
                color: Theme.of(context).primaryColorDark,
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                              radius: 64,
                              child: Icon(
                                Icons.supervised_user_circle,
                                size: 128,
                              )),
                          Text(
                            "Corona Tracker",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.grey.shade900),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.dashboard),
                      title: Text('DashBoard'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Item 2'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh,color: Colors.white),
                onPressed: (){
                  widget.model.fetchAffectedCountries(clearExisting:true);
                  widget.model.fetchGlobalHistoricalData(clearExisting:true);
                },
              )
            ],
          ),
          body: _getLowerLayer(),
        );
      },
    );
  }

  List<charts.Series<HistoricalGlobalData, DateTime>> _casesData() {
    return [
      new charts.Series(
          id: "Cases",
          data: widget.model.historicalGlobalData,
          domainFn: (HistoricalGlobalData h, _) => DateTime.parse(h.date),
          measureFn: (HistoricalGlobalData h, _) => int.parse(h.confimed)),
    ];
  }

  List<charts.Series<HistoricalGlobalData, DateTime>> _deathsData() {
    return [
      new charts.Series(
          id: "Deaths",
          data: widget.model.historicalGlobalData,
          domainFn: (HistoricalGlobalData h, _) => DateTime.parse(h.date),
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          measureFn: (HistoricalGlobalData h, _) => int.parse(h.deaths)),
    ];
  }

  List<charts.Series<LinScale, String>> _pieData() {
    final data = [
      new LinScale(
          widget.model.globalData.total_active_cases -
              widget.model.globalData.total_serious_cases,
          "Mild",
          charts.MaterialPalette.blue.shadeDefault),
      new LinScale(
          widget.model.globalData.total_recovered +
              widget.model.globalData.total_deaths,
          "Closed",
          charts.MaterialPalette.pink.shadeDefault),
      new LinScale(widget.model.globalData.total_active_cases, "Active",
          charts.MaterialPalette.purple.shadeDefault),
      new LinScale(widget.model.globalData.total_deaths, "Deaths",
          charts.MaterialPalette.red.shadeDefault),
      new LinScale(widget.model.globalData.total_recovered, "Recovered",
          charts.MaterialPalette.green.shadeDefault),
      new LinScale(widget.model.globalData.total_serious_cases, "Serious",
          charts.MaterialPalette.yellow.shadeDefault),
    ];
    return [
      new charts.Series<LinScale, String>(
          data: data,
          id: "summary",
          measureFn: (LinScale numb, _) => numb.cases,
          domainFn: (LinScale n, _) => '${n.title}: ${(n.cases*100/widget.model.globalData.total_cases).truncate()}%',
          colorFn: (LinScale n, _) => n.color,
          labelAccessorFn: (LinScale row, _) => '${row.cases}'),
    ];
  }

  List<charts.Series<HistoricalGlobalData, DateTime>> _recoveredData() {
    return [
      new charts.Series(
          id: "Recovered",
          data: widget.model.historicalGlobalData,
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

  

  Widget casesChart() {
   
   
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
                child: Center(child: Text("Total Cases",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),

   
              Container(
                height: chartHeight,
                padding: EdgeInsets.all(12),
                child: charts.TimeSeriesChart(
                  _casesData(),
                  behaviors: [
                    charts.PanAndZoomBehavior(),
                  ],
                   
                  domainAxis: new charts.DateTimeAxisSpec(
                      renderSpec: new charts.GridlineRendererSpec(
                          labelStyle: new charts.TextStyleSpec(
                              fontSize: 10, color: charts.MaterialPalette.white),
                          lineStyle: new charts.LineStyleSpec(
                              color: charts.MaterialPalette.gray.shade700))),
                  primaryMeasureAxis: new charts.NumericAxisSpec(
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

  Widget deathsChart() {
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
                child: Center(child: Text("Total Deaths",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),

              Container(
                height: chartHeight,
                padding: EdgeInsets.all(12),
                child: charts.TimeSeriesChart(
                  _deathsData(),
                  behaviors: [
                    charts.PanAndZoomBehavior(),
                  ],
                  domainAxis: new charts.DateTimeAxisSpec(
                      renderSpec: new charts.GridlineRendererSpec(
                          labelStyle: new charts.TextStyleSpec(
                              fontSize: 10, color: charts.MaterialPalette.white),
                          lineStyle: new charts.LineStyleSpec(
                              color: charts.MaterialPalette.gray.shade700))),
                  primaryMeasureAxis: new charts.NumericAxisSpec(
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

  Widget recoveredChart() {
   return Card(
      elevation: 8,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.only(bottom:12),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top:16,bottom: 8),
                child: Center(child: Text("Total Recoveries",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),

              Container(
                height: chartHeight,
                padding: EdgeInsets.all(12),
                child: charts.TimeSeriesChart(
                  _recoveredData(),
                  behaviors: [
                    charts.PanAndZoomBehavior(),
                  ],
                  domainAxis: new charts.DateTimeAxisSpec(
                      renderSpec: new charts.GridlineRendererSpec(
                          labelStyle: new charts.TextStyleSpec(
                              fontSize: 10, color: charts.MaterialPalette.white),
                          lineStyle: new charts.LineStyleSpec(
                              color: charts.MaterialPalette.gray.shade700))),
                  primaryMeasureAxis: new charts.NumericAxisSpec(
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

  Widget _getLowerLayer() {
    double cardHeight = 140;
    double borderRadius = 12;
    if (widget.model.isLoadingHistorical || widget.model.isLoadingAffectedCountries){
      return Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
        child: Center(child: CircularProgressIndicator(),));
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
        child: Container(
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
                              widget.model.globalData.total_cases.toString(),
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
                              widget.model.globalData.total_new_cases_today>0?Icons.trending_up:Icons.trending_down,
                              size: 18,
                            ),
                             SizedBox(
                              width: 8,
                            ),
                                Text(widget.model.globalData.total_new_cases_today
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
                              widget.model.globalData.total_deaths.toString(),
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
                              widget.model.globalData.total_new_deaths_today>0?Icons.trending_up:Icons.trending_down,
                              size: 18,
                            ),
                             SizedBox(
                              width: 8,
                            ),
                                Text(widget.model.globalData.total_new_deaths_today
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
                              widget.model.globalData.total_recovered.toString(),
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
                              widget.model.globalData.total_serious_cases.toString(),
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
              casesChart(),
              SizedBox(
                height: 12,
              ),
              deathsChart(),
              SizedBox(
                height: 12,
              ),
              recoveredChart(),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getUpperLayer() {
    if (widget.model.isLoadingAffectedCountries) {
      return Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (widget.model.allAffectedCounrties.length > 0 &&
        !widget.model.isLoadingAffectedCountries) {
      return Column(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              padding: EdgeInsets.only(top: 4, bottom: 12),
              color: Theme.of(context).accentColor,
              child: Row(children: [
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Icon(
                    Icons.flag,
                    size: 16,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Country",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Cases",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,                    fontWeight: FontWeight.bold,
),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Active",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,                    fontWeight: FontWeight.bold,
),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Recovery",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,                    fontWeight: FontWeight.bold,
),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Death",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,                    fontWeight: FontWeight.bold,
),
                  ),
                ),
              ]),
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.model.allAffectedCounrties.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            maintainState: true,
                            builder: (BuildContext context) {
                        return CountryPage(widget.model, widget.model.allAffectedCounrties[index]);
                      }));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: 12,
                        top: 12,
                      ),
                      color: (index % 2 == 0
                          ? Colors.blueGrey.shade900
                          : Colors.blueGrey.shade800),
                      child: new Row(children: [
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                            flex: 1,
                            child: CachedNetworkImage(
                              imageUrl: widget.model.allAffectedCounrties[index]
                                  .countryInfo.flag,
                              height: 12,
                              width: 12,
                            )),
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.model.allAffectedCounrties[index].country,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                widget.model.allAffectedCounrties[index].cases
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "(+${widget.model.allAffectedCounrties[index].todayCases})",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                widget.model.allAffectedCounrties[index].active
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.model.allAffectedCounrties[index].recovered
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                       Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                widget.model.allAffectedCounrties[index].deaths
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "(+${widget.model.allAffectedCounrties[index].todayDeaths})",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        color: Theme.of(context).primaryColor,
        child: Center(child: Text("Error")),
      );
    }
  }
}

class LinScale {
  final int cases;

  final String title;

  final charts.Color color;

  LinScale(this.cases, this.title, this.color);
}
