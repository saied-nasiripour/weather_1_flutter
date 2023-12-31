
import 'package:flutter/material.dart';
import 'package:weather_1_flutter/core/presentation/widgets/app_background.dart';
import 'package:weather_1_flutter/core/presentation/widgets/bottom_nav.dart';
import 'package:weather_1_flutter/features/bookmark_feature/presentation/screens/bookmark_screen.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/screens/home_screen.dart';


class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    List<Widget> pageViewWidget = [
      const HomeScreen(),
      BookmarkScreen(pageController: pageController)
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
