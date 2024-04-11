import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:radarweather/entities/current_weather.dart';
import 'package:radarweather/model/weather/weather_current/weather_current.dart';

import 'package:radarweather/model/weatherV2/weather_api/weather_api.dart';

import '../../model/weatherV2/weather_api/weather_data.dart';

class GetCurrentWeather {
  CurrentWeather? currentWeather;

  WeatherData? weatherData;
  WeatherCurrent? weatherCurrent;

  Future<WeatherData> getData(lat, long) async {
    var apiKey = dotenv.env['API_WEATHERAPI'];
    String wApi =
        'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$lat,$long&days=3&aqi=no&alerts=no';
    final response = await http.get(Uri.parse(wApi));
    var jasonString = jsonDecode(response.body);

    weatherData = WeatherData(
      WeatherApi.fromJsonMap(jasonString),
    );

    return weatherData!;
  }
}
