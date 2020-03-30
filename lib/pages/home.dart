import 'package:cached_network_image/cached_network_image.dart';
import 'package:corona_tracker/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

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
          backgroundColor: Colors.white,
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
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Drawer(
              elevation: 8.0,
              child: Container(
                color: Theme.of(context).primaryColor,
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
            elevation: 0.0,
          ),
          body: _getLowerLayer(),
        );
      },
    );
  }

  Widget _getLowerLayer() {
    double cardHeight = 180;
    double borderRadius = 12;
    return Center(
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
                          Center(
                              child: Icon(
                            Icons.trending_up,
                            size: 18,
                          )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.model.globalData.total_cases,
                            style: TextStyle(fontSize: 32),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text("20562 today")
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
                          Center(
                              child: Icon(
                            Icons.trending_up,
                            size: 18,
                          )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.model.globalData.death_cases,
                            style: TextStyle(fontSize: 32),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text("20562 today")
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
                      height: cardHeight,
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
                          Center(
                              child: Icon(
                            Icons.trending_up,
                            size: 18,
                          )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.model.globalData.recovery_cases,
                            style: TextStyle(fontSize: 32),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text("20562 today")
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
                      height: cardHeight,
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
                          Center(
                              child: Icon(
                            Icons.trending_up,
                            size: 18,
                          )),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.model.globalData
                                .critical_condition_active_cases,
                            style: TextStyle(fontSize: 32),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text("20562 today")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ],
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    "CASES",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    "ACTV",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    "RCVRD",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    "DEATH",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
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
                  return Container(
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
                            imageUrl:
                                widget.model.allAffectedCounrties[index].flag,
                            height: 12,
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
                              widget.model.allAffectedCounrties[index]
                                  .total_cases,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "(+${widget.model.allAffectedCounrties[index].new_cases})",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              widget.model.allAffectedCounrties[index]
                                  .active_cases,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.model.allAffectedCounrties[index]
                              .total_recovered,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.model.allAffectedCounrties[index].total_deaths,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ]),
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
