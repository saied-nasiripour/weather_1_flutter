
import 'package:weather_1_flutter/core/resources/data_state.dart';
import 'package:weather_1_flutter/core/use_cases/use_case.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/entities/current_city_entity.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/repositories_abstract/weather_repository_abstract.dart';

class GetCurrentWeatherUseCase extends UseCase<DataState<CurrentCityEntity>, String>{
  final WeatherRepositoryAbstract weatherRepository;
  GetCurrentWeatherUseCase(this.weatherRepository);

  // callable class
  @override
  Future<DataState<CurrentCityEntity>> call(String param) {
    /// param == cityName
    return weatherRepository.fetchCurrentWeatherData(param);
  }

}