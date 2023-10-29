
import 'package:weather_1_flutter/core/resources/data_state.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/entities/current_city_entity.dart';

abstract class WeatherRepositoryInterface {

  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);
}