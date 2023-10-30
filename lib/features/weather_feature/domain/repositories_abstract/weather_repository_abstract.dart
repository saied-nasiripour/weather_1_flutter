
import 'package:weather_1_flutter/core/resources/data_state.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/entities/current_city_entity.dart';

/// interface ( or abstract) Module for the Implementation Module within the data layer
abstract class WeatherRepositoryAbstract {

  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);
}