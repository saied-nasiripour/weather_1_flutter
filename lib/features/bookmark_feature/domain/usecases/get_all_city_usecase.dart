
import 'package:weather_1_flutter/core/resources/data_state.dart';
import 'package:weather_1_flutter/core/use_cases/use_case.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/entities/city_entity.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/repositories_abstract/city_repository_abstract.dart';


class GetAllCityUseCase implements UseCase<DataState<List<CityEntity>>, NoParams>{
  final CityRepositoryAbstract _cityRepository;
  GetAllCityUseCase(this._cityRepository);

  @override
  Future<DataState<List<CityEntity>>> call(NoParams params) {
    return _cityRepository.getAllCityFromDB();
  }
}