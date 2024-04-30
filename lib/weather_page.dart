// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_aziz/weather_models.dart';
import 'package:weather_app_aziz/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('a75406a0ecb40e2338cb9020cacf5723');
  // WeatherService('');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    print(cityName);

    try {
      final weather = await _weatherService.getWeater(cityName);
      setState(() {
        _weather = weather;
        print(_weather);
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy_moon.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text('WeatherApp_Aziz'),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? 'loading city ...',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Updated ${DateTime.now().hour}:${DateTime.now().minute} WIB',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 40,
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            const SizedBox(
              height: 50,
            ),
            Text(
              '${_weather?.temperature.round()}°C',
              style: const TextStyle(color: Colors.white, fontSize: 32),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              _weather?.mainCondition ?? 'loading condition ...',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Min: ${_weather?.tempMin.round()}°C ',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Max: ${_weather?.tempMax.round()}°C',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
