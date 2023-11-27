import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../bloc/weather_bloc.dart';
import '../service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(WeatherService()),
      child: const WeatherPageContent(),
    );
  }
}

class WeatherPageContent extends StatefulWidget {
  const WeatherPageContent({super.key});

  @override
  State<WeatherPageContent> createState() => _WeatherPageContentState();
}

class _WeatherPageContentState extends State<WeatherPageContent> {
  String getAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'smoke':
        return 'assets/cloudy.json';
      case 'drizzle':
      case 'shower rain':
        return 'assets/sun&cloud.json';
      case 'thunderstorm':
      case 'rain':
        return 'assets/rainy.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().getWeather();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            size: 100,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.weather.cityName,
                            style: const TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Lottie.asset(getAnimation(state.weather.condition)),
                  Text(
                    'Expected: ${state.weather.condition}',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          } else if (state is WeatherErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<WeatherBloc>().add(GetWeatherEvent('CityName'));
          context.read<WeatherBloc>().getWeather();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
