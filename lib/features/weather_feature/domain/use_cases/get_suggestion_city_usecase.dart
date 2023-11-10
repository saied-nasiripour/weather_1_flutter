

import 'package:weather_1_flutter/core/use_cases/use_case.dart';
import 'package:weather_1_flutter/features/weather_feature/data/models/suggest_city_model.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/repositories_abstract/weather_repository_abstract.dart';

class GetSuggestionCityUseCase implements UseCase<List<Data>, String>{
  final WeatherRepositoryAbstract _weatherRepository;
  GetSuggestionCityUseCase(this._weatherRepository);

  @override
  Future<List<Data>> call(String params) {
    return _weatherRepository.fetchSuggestData(params);
  }

}