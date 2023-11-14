// City table/entity

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class CityEntity extends Equatable {

  @PrimaryKey(autoGenerate: true)
  int? id;

  final String name;

  CityEntity({required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}