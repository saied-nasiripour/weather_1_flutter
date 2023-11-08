/*
The task of this Module is only to receive raw information and pass it.
without any additional processing
*/

import 'package:dio/dio.dart';
import 'package:weather_1_flutter/core/constants/api_constants.dart';
import 'package:weather_1_flutter/core/params/forecast_params.dart';

class ApiProvider {
  final Dio _dio = Dio();

  var apiKey = ApiConstants.apiKeys1;

  // current weather api call
  Future<dynamic> callCurrentWeather(String cityName) async{
    var  response = await _dio.get(
      "${ApiConstants.baseUrl}/data/2.5/weather",
      queryParameters: {
        'q': cityName,
        'appid': apiKey,
        'units': 'metric',
        'lang': 'en', // fa | en
      }
    );
    return response;
  }

  // 7 days forecast api
  Future<dynamic> sendRequest7DaysForecast(ForecastParams params) async {

    var response = await _dio.get(
        "${ApiConstants.baseUrl}/data/2.5/onecall",
        queryParameters: {
          'lat': params.lat,
          'lon': params.lon,
          'exclude': 'minutely,hourly',
          'appid': apiKey,
          'units': 'metric'
        });

    return response;
  }

}