import 'package:flutter/material.dart';
import 'package:project_forecast/Model/weather_model.dart';
import 'package:project_forecast/Service/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//api key
  final _weatherService =
      WeatherService(apiKey: "d34313ac99bf19dfb883cd67e588c43b");
  Weather? _weather;

// fetch the weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentLocation();

    // get the weather for the City

    try {
      final weather = await _weatherService.getWeather(cityName);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

//weather animations

//init state

  @override
  void initState() {
    super.initState();
    // fetch the weather
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(
              _weather?.cityName ?? "Loading City ...",
              style: const TextStyle(color: Colors.white),
            ),
            //tempreture
            Text(
              "${_weather?.temperature.round()}°C",
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
