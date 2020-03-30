class AffectedCountry {
  final String country;
  final String country_abbreviation;
  final String total_cases;
  final String new_cases;
  final String total_deaths;
  final String total_recovered;
  final String active_cases;
  final String serious_critical;
  final String cases_per_mill_pop;
  final String flag;
  AffectedCountry(
      {this.country,
      this.country_abbreviation,
      this.total_cases,
      this.new_cases,
      this.total_deaths,
      this.total_recovered,
      this.active_cases,
      this.serious_critical,
      this.cases_per_mill_pop,
      this.flag});

  factory AffectedCountry.fromJson(Map<String, dynamic> json) {
    return AffectedCountry(
      country: json['country'],
      country_abbreviation: json['country_abbreviation'],
      total_cases: json['total_cases'],
      new_cases: json['new_cases'],
      total_deaths: json['total_deaths'],
      total_recovered: json['total_recovered'],
      active_cases: json['active_cases'],
      serious_critical: json['serious_critical'],
      cases_per_mill_pop: json['cases_per_mill_pop'],
      flag: json['flag'],
    );
  }
}
