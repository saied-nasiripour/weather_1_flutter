import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_1_flutter/core/presentation/main_wrapper.dart';
import 'package:weather_1_flutter/features/bookmark_feature/presentation/bloc/bookmark_bloc.dart';
import 'package:weather_1_flutter/features/weather_feature/presentation/bloc/home_bloc.dart';
import 'package:weather_1_flutter/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init locator(Dependency Injection)
  await setup();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<HomeBloc>()),
          BlocProvider(create: (_) => locator<BookmarkBloc>()),
        ],
        child: MainWrapper(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}
