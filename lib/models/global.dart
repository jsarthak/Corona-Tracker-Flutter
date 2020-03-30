class GlobalData {
  final int total_cases;
  final int total_recovered;
  final int total_unresolved;
  final int total_deaths;
  final int total_new_cases_today;
  final int total_new_deaths_today;
  final int total_active_cases;
  final int total_serious_cases;

  GlobalData(
      {this.total_cases,
      this.total_recovered,
      this.total_unresolved,
      this.total_deaths,
      this.total_new_cases_today,
      this.total_new_deaths_today,
      this.total_active_cases,
      this.total_serious_cases});
  // factory GlobalData.fromJson(Map<String, dynamic> json) {
  //   return GlobalData(
  //     total_cases: json['total_cases'].toString(),
  //     total_recovered: json['total_recovered'].toString(),
  //     total_unresolved: json['total_unresolved'].toString(),
  //     total_deaths: json['total_deaths'].toString(),
  //     total_new_cases_today: json['total_new_cases_today'].toString(),
  //     total_new_deaths_today: json['total_new_deaths_today'].toString(),
  //     total_active_cases: json['total_active_cases'].toString(),
  //     total_serious_cases: json['total_serious_cases'].toString(),
  //   );
  // }
}
