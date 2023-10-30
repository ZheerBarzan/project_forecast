import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_forecast/Model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/3.0/weather";
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.formJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Load');
    }
  }

  Future<String> getCurrentLocation() async {
    // getting permission from the user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // fetch the current location

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // convert the Location into a List of placemark object

    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //Extract the city name from the first place mark

    String? city = placemark[0].locality;

    return city ?? "";
  }
}
