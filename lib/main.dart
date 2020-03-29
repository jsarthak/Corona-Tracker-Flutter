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
    FlutterStatusbarcolor.setNavigationBarColor(Colors.grey.shade900);
    //FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
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
              color: Colors.grey.shade900,
            ),
            padding: EdgeInsets.only(left: 16),
            child: ListTile(
              trailing: Icon(
                Icons.arrow_drop_up,
                color: Colors.white,
              ),
              title: Text(
                "Statistics",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLowerLayer() {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16),
              child: Text(
                "Dashboard",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(children: [
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Container(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "4545",
                            style: TextStyle(fontSize: 64),
                          ),
                          Text("Cases")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Container(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "4545",
                            style: TextStyle(fontSize: 64),
                          ),
                          Text("Cases")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 24,
            ),
            Row(children: [
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Container(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "4545",
                            style: TextStyle(fontSize: 64),
                          ),
                          Text("Cases")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Container(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "4545",
                            style: TextStyle(fontSize: 64),
                          ),
                          Text("Cases")
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
