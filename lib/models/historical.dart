class HistoricalGlobalData {
  final String date;
  final String confimed;
  final String deaths;
  final String recovered;

  HistoricalGlobalData({this.date, this.confimed, this.deaths, this.recovered});
  factory HistoricalGlobalData.fromJson(String id, Map<String, dynamic> json) {
    return HistoricalGlobalData(
        date: id,
        confimed: json['confirmed'].toString(),
        deaths: json['deaths'].toString(),
        recovered: json['recovered'].toString());
  }
  DateTime get historyDate {
    return DateTime.parse(this.date);
  }
}
