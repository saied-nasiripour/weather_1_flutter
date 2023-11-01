part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

// cw == current weather
class LoadCwEvent extends HomeEvent {
  // get current weather using this event
  final String cityName;
  LoadCwEvent(this.cityName);
}
