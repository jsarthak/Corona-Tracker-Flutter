import 'package:corona_tracker/models/countryinfo.dart';

class AffectedCountry {
  final String country;
  final String cases;
  final String todayCases;
  final String todayDeaths;
  final String deaths;
  final String recovered;
  final String active;
  final String critical;
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
        cases: json['cases'].toString(),
        todayCases: json['todayCases'].toString(),
        todayDeaths: json['todayDeaths'].toString(),
        deaths: json['deaths'].toString(),
        recovered: json['recovered'].toString(),
        active: json['active'].toString(),
        critical: json['critical'].toString(),
        casesPerOneMillion: json['casesPerOneMillion'].toString(),
        deathsPerOneMillion: json['deathsPerOneMillion'].toString(),
        countryInfo: CountryInfo.fromJson(json['countryInfo']));
  }
}
