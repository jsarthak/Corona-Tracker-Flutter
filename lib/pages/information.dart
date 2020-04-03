import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        elevation: 0,
        title: Text('Information'),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: _pageBody(context),
    );
  }

  List<Widget> symptomsPages = [
    symptomsPage('assets/icons/cough.png', 'Cough', ''),
    symptomsPage('assets/icons/temperature.png', 'Fever', ''),
    symptomsPage('assets/icons/headache.png', 'Tiredness', ''),
    symptomsPage(
        'assets/icons/lung.png', 'Difficulty breathing (severe cases)', '')
  ];

  List<Widget> preventionPages = [
    preventionPage('assets/icons/soap.png', 'DO:',
        'Wash your hands regularly for 20 seconds, with soap and water or alcohol-based hand rub'),
    preventionPage('assets/icons/medical_mask.png', 'DO:',
        'Cover your nose and mouth with a disposable tissue or flexed elbow when you cough or sneeze'),
    preventionPage('assets/icons/safety.png', 'DO:',
        'Avoid close contact (1 meter or 3 feet) with people who are unwell'),
    preventionPage('assets/icons/stayhome.png', 'DO:',
        'Stay home and self-isolate from others in the household if you feel unwell'),
    preventionPage('assets/icons/hand.png', 'DONT::',
        'Touch your eyes, nose, or mouth if your hands are not clean'),
  ];

  Widget _pageBody(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Text(
            ' Coronavirus disease (COVID‑19) ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'Coronavirus disease (COVID-19) is an infectious disease caused by a new virus. \nThe disease causes respiratory illness (like the flu) with symptoms such as a cough, fever, and in more severe cases, difficulty breathing. You can protect yourself by washing your hands frequently, avoiding touching your face, and avoiding close contact (1 meter or 3 feet) with people who are unwell.',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'How it spreads',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'Coronavirus disease spreads primarily through contact with an infected person when they cough or sneeze. It also spreads when a person touches a surface or object that has the virus on it, then touches their eyes, nose, or mouth.',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Symptoms',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'People may be sick with the virus for 1 to 14 days before developing symptoms. The most common symptoms of coronavirus disease (COVID-19) are fever, tiredness, and dry cough. Most people (about 80%) recover from the disease without needing special treatment. \nMore rarely, the disease can be serious and even fatal. Older people, and people with other medical conditions (such as asthma, diabetes, or heart disease), may be more vulnerable to becoming severely ill.',
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 360,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return symptomsPages[symptomsPages.length - 1 - index];
              },
              itemCount: symptomsPages.length,
              itemWidth: MediaQuery.of(context).size.width * 0.8,
              autoplay: false,
              loop: false,
              layout: SwiperLayout.STACK,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Prevention',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'There’s currently no vaccine to prevent coronavirus disease (COVID-19). You can protect yourself and help prevent spreading the virus to others if you:',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 360,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return preventionPages[preventionPages.length - 1 - index];
              },
              itemCount: preventionPages.length,
              itemWidth: MediaQuery.of(context).size.width * 0.8,
              autoplay: false,
              loop: false,
              layout: SwiperLayout.STACK,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              color: Theme.of(context).primaryColor,
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: GestureDetector(
                onTap: () async {
                  if (await canLaunch(
                      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019')) {
                    await launch(
                        'https://www.who.int/emergencies/diseases/novel-coronavirus-2019');
                  }
                },
                child: ListTile(
                  leading: Icon(Icons.public),
                  title: Text('Learn more on who.int'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  static Widget preventionPage(String url, String title, String message) {
    return Card(
      elevation: 8,
      color: Color.fromARGB(255, 56, 63, 71),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: title == 'DO:' ? Colors.green : Colors.red,
                      )),
                ),
              ),
              Expanded(
                flex: 3,
                child: Image.asset(
                  url,
                  height: 144,
                  width: 144,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget symptomsPage(String url, String title, String message) {
    return Card(
      elevation: 8,
      color: Color.fromARGB(255, 56, 63, 71),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      )),
                ),
              ),
              Expanded(
                flex: 3,
                child: Image.asset(
                  url,
                  height: 144,
                  width: 144,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
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
