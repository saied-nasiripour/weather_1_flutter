// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:weather_1_flutter/features/bookmark_feature/data/data_source/local/city_dao.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/entities/city_entity.dart';


part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [CityEntity])
abstract class AppDatabase extends FloorDatabase {
  CityDao get cityDao;
}