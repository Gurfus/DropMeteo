import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:radarweather/model/aemetWeather/Current/current_aemet/current_aemet.dart';
import 'package:radarweather/model/aemetWeather/weather_aemet.dart';

import 'package:radarweather/provider/db_provider.dart';

class GetCurrentWeatherAemet {
  String? estacion;
  WeatherAemet? weatherAemet;

  getEstacion(lat, long) async {
    final resultado = await DbProvider.db.buscarEstacionCercana(lat, long);
    return resultado;
  }

  Future<CurrentAemet?> getCurrentAemet(lat, lon) async {
    var estacion = await getEstacion(lat, lon);
    var apiKey = dotenv.env['API_KEY_AEMET'];
    estacion = estacion.values.first;

    String apiAemetCurrent =
        'https://opendata.aemet.es/opendata/api/observacion/convencional/datos/estacion/$estacion?api_key=$apiKey';
    final response = await http.get(Uri.parse(apiAemetCurrent));
    var jsonAemet = jsonDecode(response.body);
    var data = jsonAemet['datos'];

    final responseWeather = await http.get(Uri.parse(data));
    var jsonWeather = jsonDecode(responseWeather.body);
    Iterable datas = jsonWeather;
    List<CurrentAemet> currentAemetDatas = List<CurrentAemet>.from(
        datas.map((model) => CurrentAemet.fromJson(model)));

    weatherAemet = WeatherAemet(currentAemet: currentAemetDatas.last);

    return weatherAemet!.currentAemet;
  }
}
