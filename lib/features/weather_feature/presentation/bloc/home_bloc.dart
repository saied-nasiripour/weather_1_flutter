import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_1_flutter/core/params/forecast_params.dart';
import 'package:weather_1_flutter/core/resources/data_state.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/use_cases/get_current_weather_usecase.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/use_cases/get_forecast_weather_usecase.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/bloc/cw_status.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/bloc/fw_status.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final  GetForecastWeatherUseCase _getForecastWeatherUseCase;

  HomeBloc(this.getCurrentWeatherUseCase, this._getForecastWeatherUseCase) : super(HomeState(cwStatus: CwLoading(), fwStatus: FwLoading())) {
    // Type of state: HomeState()

    on<LoadCwEvent>((event, emit) async {
      emit(state.copyWith(newCwStatus: CwLoading()));
      DataState dataState = await getCurrentWeatherUseCase(event.cityName);
      if (dataState is DataSuccess) {
        emit(state.copyWith(newCwStatus: CwCompleted(dataState.data)));
      } else if (dataState is DataFailed) {
        emit(state.copyWith(newCwStatus: CwError(dataState.error!)));
      }
    });

    // load 7 days Forecast weather for city Event
    on<LoadFwEvent>((event, emit) async {

      // emit State to Loading for just Fw
      emit(state.copyWith(newFwStatus: FwLoading()));

      DataState dataState = await _getForecastWeatherUseCase(event.forecastParams);

      // emit State to Completed for just Fw
      if(dataState is DataSuccess){
        emit(state.copyWith(newFwStatus: FwCompleted(dataState.data)));
      }

      // emit State to Error for just Fw
      if(dataState is DataFailed){
        emit(state.copyWith(newFwStatus: FwError(dataState.error)));
      }
    });

  }

}
