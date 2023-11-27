import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../service/weather_service.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Cubit<WeatherState> {
  final WeatherService weatherService;

  WeatherBloc(this.weatherService) : super(WeatherInitialState());

  void getWeather() async {
    emit(WeatherLoadingState());
    try {
      String city = await weatherService.getCurrentCity();
      WeatherModel weather = await weatherService.getWeatherData(city);
      emit(WeatherLoadedState(weather));
    } catch (e) {
      emit(WeatherErrorState(e.toString()));
    }
  }

  void getCurrentCity() async {
    emit(CityLoadingState());
    try {
      String city = await weatherService.getCurrentCity();
      emit(CityLoadedState(cityName: city));
    } catch (e) {
      emit(WeatherErrorState('Failed to get current city'));
    }
  }

  // Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
  //   if (event is GetWeatherEvent) {
  //     yield WeatherLoadingState();
  //     try {
  //       WeatherModel weather = await weatherService.getWeatherData(event.city);
  //       yield WeatherLoadedState(weather);
  //     } catch (e) {
  //       yield WeatherErrorState('Failed to fetch weather data');
  //     }
  //   } else if (event is GetCurrentCityEvent) {
  //     yield CityLoadingState();
  //     try {
  //       String city = await weatherService.getCurrentCity();
  //       yield CityLoadedState(cityName: city);
  //     } catch (e) {
  //       yield WeatherErrorState('Failed to get current city');
  //     }
  //   }
  // }
}
