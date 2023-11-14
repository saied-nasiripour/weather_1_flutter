
import 'package:equatable/equatable.dart';
import 'package:weather_1_flutter/features/bookmark_feature/domain/entities/city_entity.dart';


abstract class SaveCityStatus extends Equatable{}

// initial state
class SaveCityInitial extends SaveCityStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// loading state
class SaveCityLoading extends SaveCityStatus{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// loaded state
class SaveCityCompleted extends SaveCityStatus{
  final CityEntity city;
  SaveCityCompleted(this.city);

  @override
  // TODO: implement props
  List<Object?> get props => [city];
}

// error state
class SaveCityError extends SaveCityStatus{
  final String? message;
  SaveCityError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
