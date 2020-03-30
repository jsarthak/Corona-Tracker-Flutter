class CountryInfo {
  final String id;
  final String iso2;
  final String iso3;
  final String lat;
  final String long;
  final String flag;

  CountryInfo({this.id, this.iso2, this.iso3, this.lat, this.long, this.flag});

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    return CountryInfo(
      id: json['counidtry'],
      iso2: json['iso2'],
      iso3: json['iso3'],
      lat: json['lat'].toString(),
      long: json['long'].toString(),
      flag: json['flag'],
    );
  }
}
