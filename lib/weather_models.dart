class Weather {
  final String cityName;
  final String countryName;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.countryName,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    // ignore: avoid_print
    print(json['sys']);
    return Weather(
        cityName: json['name'],
        countryName: 'ID',
        temperature: json['main']['temp'],
        tempMin: json['main']['temp_min'],
        tempMax: json['main']['temp_max'],
        mainCondition: json['weather'][0]['main']);
  }
}
