
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/bloc/cw_status.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/bloc/home_bloc.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // LoadCwEvent = Load current weather event
    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent("Tehran"));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.cwStatus is CwLoading) {
              return const Center(
                child: Text("Loading..."),
              );
            } else if (state.cwStatus is CwCompleted) {
              return const Center(
                child: Text("Completed..."),
              );
            } else if (state.cwStatus is CwError) {
              return const Center(
                child: Text("Error..."),
              );
            }
            return Container();
          }
      ),
    );
  }
}