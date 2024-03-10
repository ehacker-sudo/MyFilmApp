import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/home/home.dart';
// import 'package:myfilmapp/screens/movie/movie.dart';
// import 'package:myfilmapp/screens/tv/tv.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyFilmAppColors.header,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Home(),
        // '/movie': (BuildContext context) => const Movie(),
        // "/tv": (BuildContext context) => const Tv(),
      },
    );
  }
}
