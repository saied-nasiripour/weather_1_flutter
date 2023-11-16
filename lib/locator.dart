/// Dependency Injection
import 'package:floor/floor.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_1_flutter/features/bookmark_feature/data/data_source/local/database.dart';
import 'package:weather_1_flutter/features/bookmark_feature/data/repositories_implementation/city_repository_implementation.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/repositories_abstract/city_repository_abstract.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/usecases/delete_city_usecase.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/usecases/get_all_city_usecase.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/usecases/get_city_usecase.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/usecases/save_city_usecase.dart';
import 'package:weather_1_flutter/features/bookmark_feature/presentation/bloc/bookmark_bloc.dart';
import 'package:weather_1_flutter/features/weather_feature/data/data_source/remote/api_provider.dart';
import 'package:weather_1_flutter/features/weather_feature/data/repositories_implementation/weather_repository_implementation.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/repositories_abstract/weather_repository_abstract.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/use_cases/get_current_weather_usecase.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/use_cases/get_forecast_weather_usecase.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/bloc/home_bloc.dart';


// locator = dependency injection container
GetIt locator = GetIt.instance;

setup() async{

  // ------------------------------ Providing ------------------------------
  locator.registerSingleton<ApiProvider>(ApiProvider());

  // ------------------------------ Injection ------------------------------
  /*
  The registerSingleton() method takes two parameters:
  - The type of the dependency.
  - The instance of the dependency.
  */

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  // repositories
  locator.registerSingleton<WeatherRepositoryAbstract>(WeatherRepositoryImplementation(locator()));
  locator.registerSingleton<CityRepositoryAbstract>(CityRepositoryImplementation(database.cityDao));

  // use-case
  locator.registerSingleton<GetCurrentWeatherUseCase>(GetCurrentWeatherUseCase(locator()));
  locator.registerSingleton<GetForecastWeatherUseCase>(GetForecastWeatherUseCase(locator()));
  locator.registerSingleton<GetCityUseCase>(GetCityUseCase(locator()));
  locator.registerSingleton<SaveCityUseCase>(SaveCityUseCase(locator()));
  locator.registerSingleton<GetAllCityUseCase>(GetAllCityUseCase(locator()));
  locator.registerSingleton<DeleteCityUseCase>(DeleteCityUseCase(locator()));

  // BloC
  locator.registerSingleton<HomeBloc>(HomeBloc(locator(),locator()));
  locator.registerSingleton<BookmarkBloc>(BookmarkBloc(locator(),locator(),locator(),locator()));
}