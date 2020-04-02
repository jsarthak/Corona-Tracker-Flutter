import 'package:corona_tracker/models/countryinfo.dart';

class AffectedCountry {
  final String country;
  final int cases;
  final int todayCases;
  final int todayDeaths;
  final int deaths;
  final int recovered;
  final int active;
  final int critical;
  final String casesPerOneMillion;
  final String deathsPerOneMillion;
  final CountryInfo countryInfo;
  AffectedCountry(
      {this.country,
      this.cases,
      this.todayCases,
      this.todayDeaths,
      this.deaths,
      this.recovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.countryInfo});

  factory AffectedCountry.fromJson(Map<String, dynamic> json) {
    return AffectedCountry(
        country: json['country'],
        cases: int.parse(json['cases'].toString()),
        todayCases: int.parse(json['todayCases'].toString()),
        todayDeaths: int.parse(json['todayDeaths'].toString()),
        deaths: int.parse(json['deaths'].toString()),
        recovered: int.parse(json['recovered'].toString()),
        active: int.parse(json['active'].toString()),
        critical: int.parse(json['critical'].toString()),
        casesPerOneMillion: json['casesPerOneMillion'].toString(),
        deathsPerOneMillion: json['deathsPerOneMillion'].toString(),
        countryInfo: CountryInfo.fromJson(json['countryInfo']));
  }
}
