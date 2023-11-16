import 'package:floor/floor.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/entities/city_entity.dart';

@dao
abstract class CityDao {

  @Query('SELECT * FROM CityEntity')
  Future<List<CityEntity>> getAllCity();

  @Query('SELECT * FROM CityEntity WHERE name = :name')
  Future<CityEntity?> findCityByName(String name);

  @insert
  Future<void> insertCity(CityEntity city);

  @Query('SELECT FROM CityEntity WHERE name = :name')
  Future<void> deleteCityByName(String name);
}