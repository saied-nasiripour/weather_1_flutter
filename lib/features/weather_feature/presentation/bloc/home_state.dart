part of 'home_bloc.dart';

class HomeState {
  CwStatus cwStatus;

  HomeState({required this.cwStatus});

  HomeState copyWith({CwStatus? newCwStatus}) {
    return HomeState(cwStatus : newCwStatus ?? cwStatus);
    /// newCwStatus: new status
    /// cwStatus: previous status
  }
}
