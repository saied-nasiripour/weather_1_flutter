
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_1_flutter/core/presentation/widgets/app_background.dart';
import 'package:weather_1_flutter/core/presentation/widgets/bottom_nav.dart';
import 'package:weather_1_flutter/features/bookmark_feature/presentation/screens/bookmark_screen.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/entities/current_city_entity.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/bloc/cw_status.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/bloc/home_bloc.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/screens/home_screen.dart';


class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    List<Widget> pageViewWidget = [
      const HomeScreen(),
      const BookmarkScreen()
    ];

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNav(
        Controller: pageController,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AppBackground.getBackGroundImage(),
            fit: BoxFit.cover
          )
        ),
        height: height,child: PageView(
        controller: pageController,
        children: pageViewWidget,
      ),
      ),
    );
  }
}
/*
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
              // cast
              final CwCompleted cwCompleted = state.cwStatus as CwCompleted;

              final CurrentCityEntity currentCityEntity = cwCompleted.currentCityEntity;

              return Center(
                child: Text("Completed... \n ${currentCityEntity.name.toString()}"),
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
 */