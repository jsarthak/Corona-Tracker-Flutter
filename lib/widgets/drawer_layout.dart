import 'package:corona_tracker/pages/support_dev.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/pages/about.dart';
import 'package:corona_tracker/pages/information.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        elevation: 8.0,
        child: Container(
          color: Theme.of(context).primaryColorDark,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 24,
                    ),
                    Hero(
                      tag: 'icon',
                      child: Image(
                        height: 120,
                        image: AssetImage("assets/launcher/launcher.png"),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "COVID-19 Tracker",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white70),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Theme.of(context).primaryColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text('Information'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return InformationPage();
                        }));
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Theme.of(context).primaryColor,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ListTile(
                        trailing: Icon(
                          Icons.open_in_browser,
                          size: 16,
                          color: Colors.white70,
                        ),
                        leading: Icon(
                          Icons.monetization_on,
                        ),
                        title: Text('Donate'),
                        onTap: () async {
                          if (await canLaunch(
                              'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/donate')) {
                            await launch(
                                'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/donate');
                          }
                        },
                      )),
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8)),
              //     color: Theme.of(context).primaryColor,
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(8),
              //       child: ListTile(
              //         leading: Icon(Icons.laptop_mac),
              //         title: Text('Support Development'),
              //         onTap: () {
              //           Navigator.push(context,
              //               MaterialPageRoute(builder: (context) {
              //             return SupportDevelopmentPage();
              //           }));
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Theme.of(context).primaryColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text('About'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AboutPage();
                        }));
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
