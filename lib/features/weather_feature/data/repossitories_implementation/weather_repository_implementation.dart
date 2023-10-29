/*
The task of this section is pass to converted JSON into a UseCases...
without any additional processing
*/
import 'package:dio/dio.dart';
import 'package:weather_1_flutter/core/resources/data_state.dart';
import 'package:weather_1_flutter/features/weather_feature/data/data_source/remote/api_provider.dart';
import 'package:weather_1_flutter/features/weather_feature/data/models/current_city_model.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/entities/current_city_entity.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/repositories_abstract/weather_repository_abstract.dart';

class WeatherRepositoryImplementation extends WeatherRepositoryAbstract{

  WeatherRepositoryImplementation(this.apiProvider);
  ApiProvider apiProvider;
  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName) async{
    try {
      Response response = await apiProvider.callCurrentWeather(cityName);
      if (response.statusCode == 200) {
        CurrentCityEntity currentCityEntity = CurrentCityModel.fromJson(response.data);
        /*
        CurrentCityModel.fromJson => convert json to object class
        CurrentCityEntity => use (pass `object class` to presentation layer) data(json converted to object class)
         */
        return DataSuccess(currentCityEntity);
      } else {
        return const DataFailed('Something went wrong...try again');
      }
    }catch(e) {
      return const DataFailed('please check your connection');
    }
  }
}