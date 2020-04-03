import 'package:corona_tracker/models/global.dart';
import 'package:corona_tracker/models/historical.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../models/country.dart';

mixin ConnectedModels on Model {
  List<AffectedCountry> _affectedCountries = [];
  List<HistoricalGlobalData> _historicalGlobalData = [];
  List<HistoricalGlobalData> _countryHistoricalData = [];
  GlobalData _globalData;
  String _platformVersion;
  bool _isLoadingCountryHistorical = false;
  bool _isLoadingHistorical = false;
  bool _isLoadingAffectedCountries = false;

  bool _hasError = false;

  String _selCountry;
}

mixin GeneralStatsModel on ConnectedModels {
//   bool get isLoadingGeneralStats {
//     return _isLoadingGeneralStats;
//   }

  GlobalData get globalData {
    return _globalData;
  }

  bool get hasError {
    return _hasError;
  }

  Future<void> initPlatformState() async {
    try {
      _platformVersion = await FlutterSimCountryCode.simCountryCode;
    } catch (e) {
      print(e);
    }
    print(_platformVersion);
    notifyListeners();
  }

  String get platformVersion {
    return _platformVersion;
  }
}

mixin HistoricalData on ConnectedModels {
  bool get isLoadingHistorical {
    return _isLoadingHistorical;
  }

  bool get isLoadingCountryHistorical {
    return _isLoadingCountryHistorical;
  }

  List<HistoricalGlobalData> get historicalGlobalData {
    return _historicalGlobalData;
  }

  List<HistoricalGlobalData> get historicalCountryData {
    return _countryHistoricalData;
  }

  Future<Null> fetchCountryHistoricalData(String countryName,
      {clearExisting = true}) {
    var formatter = new DateFormat('yyyy-MM-dd');
    String date = formatter.format(DateTime.now());
    _isLoadingCountryHistorical = true;
    _hasError = false;
    if (clearExisting) {
      _countryHistoricalData = [];
    }
    notifyListeners();
    String url =
        "https://covidapi.info/api/v1/country/$countryName/timeseries/2020-01-21/$date";
    return http.get(url).then<Null>((http.Response response) async {
      final List<HistoricalGlobalData> historicalGlobalData1 = [];
      List<dynamic> historicalData = jsonDecode(response.body)['result'];

      if (historicalData == null) {
        _isLoadingCountryHistorical = false;
        notifyListeners();
        return;
      }
      for (Map<String, dynamic> h in historicalData) {
        final HistoricalGlobalData d = HistoricalGlobalData(
            confimed: h['confirmed'].toString(),
            date: h['date'].toString(),
            deaths: h['deaths'].toString(),
            recovered: h['recovered'].toString());
        historicalGlobalData1.add(d);
      }
      _countryHistoricalData = historicalGlobalData1;
      _isLoadingCountryHistorical = false;
      _hasError = false;
      notifyListeners();
    }).catchError((error) {
      _isLoadingCountryHistorical = false;
      _hasError = true;
      notifyListeners();
      print(error);
      return;
    });
  }

  Future<Null> fetchGlobalHistoricalData({clearExisting = true}) {
    _isLoadingHistorical = true;
    if (clearExisting) {
      _historicalGlobalData = [];
    }
    _hasError = false;
    notifyListeners();
    String url = "https://covidapi.info/api/v1/global/count";
    return http.get(url).then<Null>((http.Response response) async {
      final List<HistoricalGlobalData> historicalGlobalData1 = [];

      Map<String, dynamic> historicalData = jsonDecode(response.body)['result'];
      if (historicalData == null) {
        _isLoadingHistorical = false;
        notifyListeners();
        return;
      }
      historicalData.forEach((String id, dynamic data) {
        final HistoricalGlobalData d = HistoricalGlobalData.fromJson(id, data);
        historicalGlobalData1.add(d);
      });

      _historicalGlobalData = historicalGlobalData1;
      _isLoadingHistorical = false;
      _hasError = false;
      notifyListeners();
    }).catchError((error) {
      _hasError = true;
      _isLoadingHistorical = false;
      notifyListeners();
      print(error);
      return;
    });
  }
}

mixin AffectedCountryModel on ConnectedModels {
  bool get isLoadingAffectedCountries {
    return _isLoadingAffectedCountries;
  }

  List<AffectedCountry> get allAffectedCounrties {
    return List.from(_affectedCountries);
  }

  int get selectedCountryIndex {
    return _affectedCountries.indexWhere((AffectedCountry affectedCountry) {
      return affectedCountry.country == _selCountry;
    });
  }

  Future<Null> fetchAffectedCountries({clearExisting = true}) {
    _isLoadingAffectedCountries = true;
    _hasError = false;
    if (clearExisting) {
      _affectedCountries = [];
    }
    notifyListeners();
    return http
        .get("https://corona.lmao.ninja/countries?sort=cases")
        .then<Null>((http.Response response) {
      final List<AffectedCountry> fetchedCountryList = [];

      var affectedCountryData = jsonDecode(response.body) as List;

      if (affectedCountryData == null) {
        _isLoadingAffectedCountries = false;
        notifyListeners();
        return;
      }
      int total_cases = 0;
      int total_deaths = 0;
      int total_recovered = 0;
      int total_new_cases_today = 0;
      int total_new_deaths_today = 0;
      int total_active_cases = 0;
      int total_serious_cases = 0;
      for (Map<String, dynamic> d in affectedCountryData) {
        final AffectedCountry affectedCountry = AffectedCountry.fromJson(d);
        total_cases = total_cases + (affectedCountry.cases);
        total_deaths = total_deaths + (affectedCountry.deaths);
        total_recovered = total_recovered + (affectedCountry.recovered);
        total_new_cases_today =
            total_new_cases_today + (affectedCountry.todayCases);
        total_new_deaths_today =
            total_new_deaths_today + (affectedCountry.todayDeaths);
        total_active_cases = total_active_cases + (affectedCountry.active);
        total_serious_cases = total_serious_cases + (affectedCountry.critical);

        fetchedCountryList.add(affectedCountry);
      }
      _globalData = GlobalData(
          total_recovered: total_recovered,
          total_active_cases: total_active_cases,
          total_deaths: total_deaths,
          total_cases: total_cases,
          total_new_cases_today: total_new_cases_today,
          total_new_deaths_today: total_new_deaths_today,
          total_serious_cases: total_serious_cases,
          total_unresolved: 0);

      _affectedCountries = fetchedCountryList;
      _isLoadingAffectedCountries = false;
      _hasError = false;
      notifyListeners();
      _selCountry = null;
    }).catchError((error) {
      _isLoadingAffectedCountries = false;
      _hasError = true;
      notifyListeners();
      print(error);
      return;
    });
  }
}
