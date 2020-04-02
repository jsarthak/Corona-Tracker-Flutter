import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 0,
        title: Text('About'),
      ),
      body: Container(
          color: Theme.of(context).primaryColorDark,
          padding: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              Card(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(
                    'Build version',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('1.0.2420'),
                  leading: Icon(Icons.build),
                ),
              ),
              Card(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(
                    'Rate and Review',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Write what you love about the app'),
                  leading: Icon(Icons.star),
                ),
              ),
              Card(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(
                    'Share app',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'Get a link to share the app with your friends and enemies'),
                  leading: Icon(Icons.share),
                ),
              ),
              Text('Data Sources',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ))
            ],
          )),
    );
  }
}
