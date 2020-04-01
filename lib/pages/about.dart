import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      body:Container(
        color: Theme.of(context).primaryColorDark,
      ),
    headerSliverBuilder:(context, f){
      return [
        SliverAppBar(expandedHeight:240 ,
                backgroundColor: Theme.of(context).primaryColorDark,

        flexibleSpace: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Image(
                            height: 120,
                            image: AssetImage("assets/launcher/launcher.png"),
                            
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Corona Tracker",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white70),
                          )
        ],),),)
      ];
    });
  }
}