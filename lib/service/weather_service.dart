import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey = dotenv.get('Api_Key');

  Future<WeatherModel> getWeatherData(String city) async {
    print(dotenv.env['Api_Key']);
    print('api: $apiKey');
    final res = await http
        .get(Uri.parse('$BASE_URL?q=$city&appid=$apiKey&units=metric'));
    if (res.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('failed');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placemarks[0].locality;

    return city ?? 'Nairobi';
  }
}
