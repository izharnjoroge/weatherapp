part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class GetWeatherEvent extends WeatherEvent {
  final String city;

  GetWeatherEvent(this.city);
}

class GetCurrentCityEvent extends WeatherEvent {}
