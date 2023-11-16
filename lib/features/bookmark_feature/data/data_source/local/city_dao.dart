import 'package:floor/floor.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/entities/city_entity.dart';

@dao
abstract class CityDao {

  // table name == entity name ==> CityEntity
  @Query('SELECT * FROM CityEntity')
  Future<List<CityEntity>> getAllCity();

  // table name == entity name ==> CityEntity
  @Query('SELECT * FROM CityEntity WHERE name = :name')
  Future<CityEntity?> findCityByName(String name);

  @insert
  Future<void> insertCity(CityEntity city);

  // table name == entity name ==> CityEntity
  @Query('SELECT FROM CityEntity WHERE name = :name')
  Future<void> deleteCityByName(String name);
}