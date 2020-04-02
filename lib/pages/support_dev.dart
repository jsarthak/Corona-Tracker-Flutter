import 'package:flutter/material.dart';

class SupportDevelopmentPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Support development'),
        
      ),
      body: Container(child: Center(child: Text('Content'),),),
    );
  }
}