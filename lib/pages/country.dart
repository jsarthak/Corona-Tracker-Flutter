import 'package:corona_tracker/models/country.dart';
import 'package:corona_tracker/scoped_models/main.dart';
import 'package:flutter/material.dart';

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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
