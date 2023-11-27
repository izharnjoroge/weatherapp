class WeatherModel {
  final String cityName;
  final double temp;
  final String condition;

  WeatherModel(
      {required this.cityName, required this.temp, required this.condition});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        cityName: json['name'],
        temp: json['main']['temp'].toDouble(),
        condition: json['weather'][0]['main']);
  }
}
