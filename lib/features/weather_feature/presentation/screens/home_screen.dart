import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_1_flutter/core/params/forecast_params.dart';
import 'package:weather_1_flutter/core/presentation/widgets/dot_loading_widget.dart';
import 'package:weather_1_flutter/core/utils/date_converter.dart';
import 'package:weather_1_flutter/features/bookmark_feature/presentation/bloc/bookmark_bloc.dart';
import 'package:weather_1_flutter/features/weather_feature/data/models/forecast_days_model.dart';
import 'package:weather_1_flutter/features/weather_feature/data/models/suggest_city_model.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/entities/current_city_entity.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/entities/forecast_days_entity.dart';
import 'package:weather_1_flutter/features/weather_feature/domain/use_cases/get_suggestion_city_usecase.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/bloc/cw_status.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/bloc/fw_status.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/bloc/home_bloc.dart';
import 'package:weather_1_flutter/core/presentation/widgets/app_background.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/widgets/bookmark_icon.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/widgets/day_weather_view.dart';
import 'package:weather_1_flutter/locator.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{
  TextEditingController textEditingController = TextEditingController();
  GetSuggestionCityUseCase getSuggestionCityUseCase = GetSuggestionCityUseCase(locator());
  String cityName = "london";
  final PageController _pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(cityName));
  }

  @override
  Widget build(BuildContext context) {
    // responsive page => get height and weight of device screen
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.02,),
          // --------------------- City Search Box (Suggestion Text field) & Bookmark ---------------------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Row(
              children: [
                // search box
                Expanded(
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      onSubmitted: (String prefix) {
                        textEditingController.text = prefix;
                        BlocProvider.of<HomeBloc>(context)
                            .add(LoadCwEvent(prefix));
                      },
                      controller: textEditingController,
                      style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        hintText: "Enter a City...",
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    suggestionsCallback: (String pattern) {
                      // pattern == prefix
                      return getSuggestionCityUseCase(pattern);
                    },
                    itemBuilder: (BuildContext context, Data itemData) {
                      // itemData == SuggestCityModel
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(itemData.name!),
                        subtitle: Text("${itemData.region!}, ${itemData.country}"),
                      );
                    },
                    onSuggestionSelected: (Data suggestion) {
                      // suggestion == model
                      textEditingController.text = suggestion.name!;
                      BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(suggestion.name!));
                    },
                  ),
                ),
                const SizedBox(width: 10),
                // bookmark
                BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current){
                      if(previous.cwStatus == current.cwStatus){
                        return false;
                      }
                      return true;
                    },
                    builder: (context, state){
                      /// show Loading State for Cw (current weather)
                      if (state.cwStatus is CwLoading) {
                        return const CircularProgressIndicator();
                      }

                      if(state.cwStatus is CwCompleted){
                        final CwCompleted cwComplete = state.cwStatus as CwCompleted;
                        BlocProvider.of<BookmarkBloc>(context).add(GetCityByNameEvent(cwComplete.currentCityEntity.name!));
                        return BookMarkIcon(name: cwComplete.currentCityEntity.name!);
                      }

                      /// show Error State for Cw (current weather)
                      if (state.cwStatus is CwError) {
                        return IconButton(
                          onPressed: (){
                            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            //   content: Text("please load a city!"),
                            //   behavior: SnackBarBehavior.floating, // Add this line
                            // ));
                          },
                          icon: const Icon(Icons.error,color: Colors.white,size: 35),
                        );
                      }

                      return Container();

                    }
                ),
              ],
            ),
          ),
          // --------------------- main UI ---------------------
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) {
              // rebuild just when CwStatus changed
              if (previous.cwStatus == current.cwStatus) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              // --------------------- show Loading Status for Current Weather (CwLoading) ---------------------
              if (state.cwStatus is CwLoading) {
                return const Expanded(child: DotLoadingWidget());
              }
              // --------------------- show Completed Status for Current Weather (CwCompleted) ---------------------
              if (state.cwStatus is CwCompleted) {
                /// cast
                final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
                final CurrentCityEntity currentCityEntity =
                    cwCompleted.currentCityEntity;

                // create params for api call
                final ForecastParams forecastParams = ForecastParams(currentCityEntity.coord!.lat!, currentCityEntity.coord!.lon!);

                // start load Fw event
                BlocProvider.of<HomeBloc>(context).add(LoadFwEvent(forecastParams));

                /// change Times from second to Hour --5:55 AM/PM----
                final sunrise = DateConverter.changeDtToDateTimeHour(currentCityEntity.sys!.sunrise,currentCityEntity.timezone);
                final sunset =  DateConverter.changeDtToDateTimeHour(currentCityEntity.sys!.sunset,currentCityEntity.timezone);

                return Expanded(
                  child: ListView(
                    children: [
                      // PageView
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: SizedBox(
                          width: width,
                          height: 400,
                          child: PageView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            allowImplicitScrolling: true,
                            controller: _pageController,
                            itemCount: 2,
                            itemBuilder: (context, position) {
                              if (position == 0) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      // top: 50 => based on DP
                                      child: Text(
                                        currentCityEntity.name!,
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        currentCityEntity
                                            .weather![0].description!,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: AppBackground.setIconForMain(
                                          currentCityEntity
                                              .weather![0].description!),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      // top: 50 => based on DP
                                      child: Text(
                                        "${currentCityEntity.main!.temp!.round()}\u00B0",
                                        style: const TextStyle(
                                          fontSize: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        // --------------------- Max Temp ---------------------
                                        Column(
                                          children: [
                                            const Text(
                                              "Max",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${currentCityEntity.main!.tempMax!.round()}\u00B0",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // divider
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: Container(
                                            color: Colors.grey,
                                            width: 2,
                                            height: 50,
                                          ),
                                        ),

                                        // --------------------- Min Temp ---------------------
                                        Column(
                                          children: [
                                            const Text(
                                              "Min",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${currentCityEntity.main!.tempMin!.round()}\u00B0",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return Container(
                                  color: Colors.amber,
                                );
                              }
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // --------------------- pageView Indicator ---------------------
                      Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          // PageController
                          count: 2,
                          effect: const ExpandingDotsEffect(
                            dotWidth: 10,
                            dotHeight: 10,
                            spacing: 5,
                            activeDotColor: Colors.white,
                          ),
                          onDotClicked: (index) =>
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(microseconds: 500),
                                curve: Curves.bounceOut,
                              ),
                        ),
                      ),

                      // divider
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          color: Colors.white24,
                          height: 2,
                          width: double.infinity,
                        ),
                      ),

                      // --------------------- forecast weather 7 days ---------------------
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Center(
                              child: BlocBuilder<HomeBloc, HomeState>(
                                builder: (BuildContext context, state) {

                                  // show Loading State for Forecast Weather
                                  if (state.fwStatus is FwLoading) {
                                    return const DotLoadingWidget();
                                  }

                                  // show Completed State for Forecast Weather
                                  if (state.fwStatus is FwCompleted) {
                                    // casting
                                    final FwCompleted fwCompleted = state.fwStatus as FwCompleted;
                                    final ForecastDaysEntity forecastDaysEntity = fwCompleted.forecastDaysEntity;
                                    final List<Daily> mainDaily = forecastDaysEntity.daily!;

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 8,
                                      itemBuilder: (BuildContext context,
                                          int index,) {
                                        return DaysWeatherView(
                                          daily: mainDaily[index],);
                                      },);
                                  }

                                  // show Error State for Forecast Weather
                                  if (state.fwStatus is FwError) {
                                    final FwError fwError = state.fwStatus as FwError;
                                    return Center(
                                      child: Text(fwError.message!),
                                    );
                                  }

                                  // show Default State for Fw
                                  return Container();

                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      // divider
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          color: Colors.white24,
                          height: 2,
                          width: double.infinity,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // --------------------- last Row ---------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text("wind speed",
                                style: TextStyle(
                                  fontSize: height * 0.017, color: Colors.amber,),),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "${currentCityEntity.wind!.speed!} m/s",
                                  style: TextStyle(
                                    fontSize: height * 0.016,
                                    color: Colors.white,),),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              color: Colors.white24,
                              height: 30,
                              width: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: [
                                Text("sunrise",
                                  style: TextStyle(
                                    fontSize: height * 0.017,
                                    color: Colors.amber,),),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 10.0),
                                  child: Text(sunrise,
                                    style: TextStyle(
                                      fontSize: height * 0.016,
                                      color: Colors.white,),),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              color: Colors.white24,
                              height: 30,
                              width: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(children: [
                              Text("sunset",
                                style: TextStyle(
                                  fontSize: height * 0.017, color: Colors.amber,),),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(sunset,
                                  style: TextStyle(
                                    fontSize: height * 0.016,
                                    color: Colors.white,),),
                              ),
                            ],),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              color: Colors.white24,
                              height: 30,
                              width: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(children: [
                              Text("humidity",
                                style: TextStyle(
                                  fontSize: height * 0.017, color: Colors.amber,),),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "${currentCityEntity.main!.humidity!}%",
                                  style: TextStyle(
                                    fontSize: height * 0.016,
                                    color: Colors.white,),),
                              ),
                            ],),
                          ),
                        ],),

                      const SizedBox(height: 30),
                    ],
                  ),
                );
              }
              // --------------------- show Error Status for Current Weather (CwError) ---------------------
              if (state.cwStatus is CwError) {
                return const Center(
                  child: Text('error'),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  @override
  // Prevent the home-screen from being rebuilt
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}