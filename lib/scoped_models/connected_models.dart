import 'package:corona_tracker/models/global.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../models/country.dart';

mixin ConnectedModels on Model {
  List<AffectedCountry> _affectedCountries = [];
  GlobalData _globalData;
  bool _isLoadingGeneralStats = false;
  bool _isLoadingAffectedCountries = false;
  String _selCountry;
}

mixin GeneralStatsModel on ConnectedModels {
  bool get isLoadingGeneralStats {
    return _isLoadingGeneralStats;
  }

  GlobalData get globalData {
    return _globalData;
  }

  Future<Null> fetchGeneralStats({clearExisting = true}) {
    _isLoadingGeneralStats = true;
    notifyListeners();
    return http
        .get(
            "https://corona-virus-stats.herokuapp.com/api/v1/cases/general-stats")
        .then<Null>((http.Response response) {
      Map<String, dynamic> data = jsonDecode(response.body);
      var global = data['data'];
      final GlobalData t = GlobalData.fromJson(global);
      _globalData = t;
      _isLoadingGeneralStats = false;
      notifyListeners();
    }).catchError((error) {
      _isLoadingGeneralStats = false;
      notifyListeners();
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
        .get(
            "https://corona-virus-stats.herokuapp.com/api/v1/cases/countries-search?limit=200")
        .then<Null>((http.Response response) {
      final List<AffectedCountry> fetchedCountryList = [];
      Map<String, dynamic> data = jsonDecode(response.body);

      var affectedCountryData = data['data']['rows'] as List;

      if (affectedCountryData == null) {
        _isLoadingAffectedCountries = false;
        notifyListeners();
        return;
      }
      for (dynamic d in affectedCountryData) {
        final AffectedCountry affectedCountry = AffectedCountry.fromJson(d);
        fetchedCountryList.add(affectedCountry);
      }

      _affectedCountries = fetchedCountryList;
      _isLoadingAffectedCountries = false;
      notifyListeners();
      _selCountry = null;
    }).catchError((error) {
      _isLoadingAffectedCountries = false;
      notifyListeners();
      return;
    });
  }
}
