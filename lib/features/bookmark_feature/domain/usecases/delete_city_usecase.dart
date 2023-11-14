
import 'package:weather_1_flutter/core/resources/data_state.dart';
import 'package:weather_1_flutter/core/use_cases/use_case.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/repositories_abstract/city_repository_abstract.dart';

class DeleteCityUseCase implements UseCase<DataState<String>, String>{
  final CityRepositoryAbstract _cityRepository;
  DeleteCityUseCase(this._cityRepository);

  @override
  Future<DataState<String>> call(String params) {
    return _cityRepository.deleteCityByName(params);
  }
}