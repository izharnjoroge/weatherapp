part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class CityLoadingState extends WeatherState {}

class CityLoadedState extends WeatherState {
  final String cityName;

  CityLoadedState({required this.cityName});
}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weather;

  WeatherLoadedState(this.weather);
}

class WeatherErrorState extends WeatherState {
  final String error;

  WeatherErrorState(this.error);
}
