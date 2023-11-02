import 'package:flutter/material.dart';
import 'package:weather_1_flutter/core/widgets/main_wrapper.dart';
import 'package:weather_1_flutter/locator.dart';

void main() async{
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      home: MainWrapper(),
    );
  }
}
