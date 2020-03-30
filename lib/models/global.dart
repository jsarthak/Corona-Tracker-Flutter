class GlobalData {
  final String total_cases;
  final String recovery_cases;
  final String death_cases;
  final String last_update;
  final String currently_infected;
  final String cases_with_outcome;
  final String mild_condition_active_cases;

  final String critical_condition_active_cases;
  final String recovered_closed_cases;
  final String death_closed_cases;
  final String closed_cases_recovered_percentage;
  final String closed_cases_death_percentage;
  final String active_cases_mild_percentage;

  final String active_cases_critical_percentage;
  final String general_death_rate;

  GlobalData(
      {this.total_cases,
      this.recovery_cases,
      this.death_cases,
      this.last_update,
      this.currently_infected,
      this.cases_with_outcome,
      this.mild_condition_active_cases,
      this.critical_condition_active_cases,
      this.recovered_closed_cases,
      this.death_closed_cases,
      this.closed_cases_recovered_percentage,
      this.closed_cases_death_percentage,
      this.active_cases_mild_percentage,
      this.active_cases_critical_percentage,
      this.general_death_rate});

  factory GlobalData.fromJson(Map<String, dynamic> json) {
    return GlobalData(
      total_cases: json['total_cases'],
      recovery_cases: json['recovery_cases'],
      death_cases: json['death_cases'],
      last_update: json['last_update'],
      currently_infected: json['currently_infected'],
      cases_with_outcome: json['cases_with_outcome'],
      mild_condition_active_cases: json['mild_condition_active_cases'],
      critical_condition_active_cases: json['critical_condition_active_cases'],
      recovered_closed_cases: json['recovered_closed_cases'],
      death_closed_cases: json['death_closed_cases'],
      closed_cases_recovered_percentage:
          json['closed_cases_recovered_percentage'],
      closed_cases_death_percentage: json['closed_cases_death_percentage'],
      active_cases_mild_percentage: json['active_cases_mild_percentage'],
      active_cases_critical_percentage:
          json['active_cases_critical_percentage'],
      general_death_rate: json['general_death_rate'],
    );
  }
}
