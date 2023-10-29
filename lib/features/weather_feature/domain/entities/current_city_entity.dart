/*
 Entity == Data Holder
 This class's only Task is to act as an information keeper (or use Variables)
 data => domain(Entity) => presentation
*/

import 'package:equatable/equatable.dart';
import 'package:weather_1_flutter/features/weather_feature/data/models/current_city_model.dart';

class CurrentCityEntity extends Equatable {

  const CurrentCityEntity({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
});

  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final Main? main;
  final num? visibility;
  final Wind? wind;
  final Rain? rain;
  final Clouds? clouds;
  final num? dt;
  final Sys? sys;
  final num? timezone;
  final num? id;
  final String? name;
  final num? cod;

  @override
  // TODO: implement props
  List<Object?> get props => [
    coord,
    weather,
    base,
    main
  ];
}
