import 'package:corona_tracker/scoped_models/main.dart';
import 'package:corona_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:scoped_model/scoped_model.dart';
import 'pages/home.dart';

void main() => runApp(CoronaApp());

class CoronaApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CoronaAppState();
  }
}

class _CoronaAppState extends State<CoronaApp> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    FlutterStatusbarcolor.setNavigationBarColor(
        Color.fromARGB(255, 44, 51, 61));
    FlutterStatusbarcolor.setStatusBarColor(Color.fromARGB(255, 44, 51, 61));
    _model.fetchAffectedCountries(clearExisting: true);
    _model.fetchGeneralStats(clearExisting: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: "Corona Tracker",
        theme: appThemeMain,
        home: HomePage(model: _model),
      ),
    );
  }
}
