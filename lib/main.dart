import 'package:corona_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:rubber/rubber.dart';

void main() => runApp(CoronaApp());

class CoronaApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return _CoronaAppState();
  }
}

class _CoronaAppState extends State<CoronaApp> {
  @override
  void initState() {
    super.initState();
    FlutterStatusbarcolor.setNavigationBarColor(
        Color.fromARGB(255, 44, 51, 61));
    FlutterStatusbarcolor.setStatusBarColor(Color.fromARGB(255, 44, 51, 61));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appThemeMain,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  RubberAnimationController _controller;

  @override
  void dispose() {
    _controller.removeStatusListener(_statusListener);
    _controller.animationState.removeListener(_stateListener);
    super.dispose();
  }

  void _stateListener() {
    print("state changed ${_controller.animationState.value}");
  }

  void _statusListener(AnimationStatus status) {
    print("changed status ${_controller.status}");
  }

  void _expand() {
    _controller.expand();
  }

  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        lowerBoundValue: AnimationControllerValue(pixel: 50),
        duration: Duration(milliseconds: 200));
    _controller.addStatusListener(_statusListener);
    _controller.animationState.addListener(_stateListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          elevation: 8.0,
          child: Container(
            color: Colors.white,
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
      body: Container(
        child: RubberBottomSheet(
          lowerLayer: _getLowerLayer(),
          upperLayer: _getUpperLayer(),
          animationController: _controller,
          header: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              color: Theme.of(context).primaryColor,
            ),
            padding: EdgeInsets.only(left: 16),
            child: ListTile(
              trailing: Icon(
                Icons.arrow_drop_up,
                color: Colors.white,
              ),
              title: Text(
                "Affected Countries",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
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
                            "683641",
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
                            "32144",
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
                            "683641",
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
                            "32144",
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
    return Container(
        decoration: BoxDecoration(color: Colors.grey.shade900),
        child: ListView.builder(
          padding: EdgeInsets.only(left: 8, right: 8),
          scrollDirection: Axis.vertical,
          itemCount: 202,
          itemBuilder: (BuildContext context, int index) {
            return new Row(children: [
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: Icon(Icons.flag, color: Colors.red, size: 24),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Country Name",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: Text(
                  (5 * index).toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Text(
                  (5 * index).toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Text(
                  (5 * index).toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Text(
                  (5 * index).toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ]);
          },
        ));
  }
}
