
import 'package:weather_1_flutter/core/resources/data_state.dart';
import 'package:weather_1_flutter/core/use_cases/use_case.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/entities/city_entity.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/repositories_abstract/city_repository_abstract.dart';

class GetCityUseCase implements UseCase<DataState<CityEntity?>, String>{
  final CityRepositoryAbstract _cityRepository;
  GetCityUseCase(this._cityRepository);

  @override
  Future<DataState<CityEntity?>> call(String params) {
      return _cityRepository.findCityByName(params);
  }
}