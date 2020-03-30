import 'package:corona_tracker/models/global.dart';
import 'package:corona_tracker/models/historical.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../models/country.dart';

mixin ConnectedModels on Model {
  List<AffectedCountry> _affectedCountries = [];
  List<HistoricalGlobalData> _historicalGlobalData = [];
  GlobalData _globalData;
  bool _isLoadingHistorical = false;
  bool _isLoadingAffectedCountries = false;
  String _selCountry;
}

mixin GeneralStatsModel on ConnectedModels {
//   bool get isLoadingGeneralStats {
//     return _isLoadingGeneralStats;
//   }

  GlobalData get globalData {
    return _globalData;
  }

//   Future<Null> fetchGeneralStats({clearExisting = true}) {
//     _isLoadingGeneralStats = true;
//     notifyListeners();
//     return http
//         .get("https://thevirustracker.com/free-api?global=stats")
//         .then<Null>((http.Response response) {
//       Map<String, dynamic> data = jsonDecode(response.body);
//       var global = data['results'][0];
//       final GlobalData t = GlobalData.fromJson(global);
//       _globalData = t;
//       _isLoadingGeneralStats = false;
//       notifyListeners();
//     }).catchError((error) {
//       _isLoadingGeneralStats = false;
//       notifyListeners();
//       return;
//     });
//   }
}

mixin HistoricalData on ConnectedModels {
  bool get isLoadingHistorical {
    return _isLoadingHistorical;
  }

  List<HistoricalGlobalData> get historicalGlobalData {
    return _historicalGlobalData;
  }

  Future<Null> fetchGlobalHistoricalData({clearExisting = true}) {
    _isLoadingHistorical = true;
    if (clearExisting) {
      _historicalGlobalData = [];
    }
    notifyListeners();
    return http
        .get("https://covidapi.info/api/v1/global/count")
        .then<Null>((http.Response response) {
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
      notifyListeners();
    }).catchError((error) {
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
        total_cases = total_cases + int.parse(affectedCountry.cases);
        total_deaths = total_deaths + int.parse(affectedCountry.deaths);
        total_recovered =
            total_recovered + int.parse(affectedCountry.recovered);
        total_new_cases_today =
            total_new_cases_today + int.parse(affectedCountry.todayCases);
        total_new_deaths_today =
            total_new_deaths_today + int.parse(affectedCountry.todayDeaths);
        total_active_cases =
            total_active_cases + int.parse(affectedCountry.active);
        total_serious_cases =
            total_serious_cases + int.parse(affectedCountry.critical);

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
      notifyListeners();
      _selCountry = null;
    }).catchError((error) {
      _isLoadingAffectedCountries = false;

      notifyListeners();
      print(error);
      return;
    });
  }
}
