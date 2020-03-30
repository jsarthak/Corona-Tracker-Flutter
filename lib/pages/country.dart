import 'package:corona_tracker/scoped_models/main.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  final MainModel model;
  CountryPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _CountryPageState();
  }
}

class _CountryPageState extends State<CountryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
      ),
    );
  }
}
