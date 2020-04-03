import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  String urlCSSEGI = 'https://github.com/CSSEGISandData/COVID-19';
  String urlWorldOmeter = 'https://www.worldometers.info/coronavirus/';
  String whoSituation =
      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports/';
  String urlCDC = 'https://www.cdc.gov/coronavirus/2019-nCoV/index.html';
  String who =
      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019';
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      'Build version',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('1.0.2420'),
                    leading: Icon(Icons.build),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Card(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      'Rate and Review',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Write what you love about the app'),
                    leading: Icon(Icons.star),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Card(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
              ),
              SizedBox(height: 16),
              Text('Data Sources',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(urlCSSEGI);
                },
                child: Card(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        'Novel Coronavirus (COVID-19) Cases, provided by JHU CSSE ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(Icons.public),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  launchUrl(urlWorldOmeter);
                },
                child: Card(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        'Worldometer ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(Icons.public),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  launchUrl(whoSituation);
                },
                child: Card(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        'Coronavirus disease (COVID-2019) situation reports ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(Icons.public),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  launchUrl(urlCDC);
                },
                child: Card(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        'Coronavirus (COVID-19) - CDC',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(Icons.public),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  launchUrl(who);
                },
                child: Card(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        'Coronavirus disease (COVID-19) Pandemic- WHO',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(Icons.public),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
