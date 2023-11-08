
import 'package:weather_1_flutter/core/params/forecast_params.dart';
import 'package:weather_1_flutter/core/resources/data_state.dart';
import 'package:weather_1_flutter/core/use_cases/use_case.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/entities/forecast_days_entity.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/repositories_abstract/weather_repository_abstract.dart';

class GetForecastWeatherUseCase implements UseCase<DataState<ForecastDaysEntity>, ForecastParams>{
  final WeatherRepositoryAbstract _weatherRepository;
  GetForecastWeatherUseCase(this._weatherRepository);

  @override
  Future<DataState<ForecastDaysEntity>> call(ForecastParams params) {
    return _weatherRepository.fetchForecastWeatherData(params);
  }

}