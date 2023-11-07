import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  BottomNav({Key? key, required this.Controller}) : super(key: key);

  PageController Controller;

  @override
  Widget build(BuildContext context) {

    var primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: primaryColor,
      notchMargin: 5,
      child: SizedBox(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: (){
                Controller.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.home),
            ),
            const SizedBox(),
            IconButton(
              onPressed: (){
                Controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.bookmark),
            ),
          ],
        ),
      ),
    );
  }
}
