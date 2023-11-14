
import 'package:weather_1_flutter/core/resources/data_state.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/entities/city_entity.dart';

abstract class CityRepositoryAbstract {
  Future<DataState<CityEntity>> saveCityToDB(String cityName);

  Future<DataState<List<CityEntity>>> getAllCityFromDB();

  Future<DataState<CityEntity?>> findCityByName(String name);

  Future<DataState<String>> deleteCityByName(String name);
}