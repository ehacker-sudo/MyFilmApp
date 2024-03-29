import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/detail/episode_detail.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/screens/detail/person_detail.dart';
import 'package:myfilmapp/screens/form/add_review.dart';
import 'package:myfilmapp/screens/home/home.dart';
import 'package:myfilmapp/screens/season/movie_collections.dart';
import 'package:myfilmapp/screens/season/tv_episode.dart';
import 'package:myfilmapp/screens/season/tv_season.dart';
// import 'package:myfilmapp/screens/movie/movie.dart';
// import 'package:myfilmapp/screens/tv/tv.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: MyFilmAppColors.header,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
        GlobalKey<ScaffoldMessengerState>();
    return MaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      title: 'Film App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const Home(),
        '/filmDetail': (BuildContext context) => const FilmDetail(),
        "/episodeDetail": (BuildContext context) => const EpisodeDetail(),
        "/personDetail": (BuildContext context) => const PersonDetail(),
        "/tvSeason": (BuildContext context) => const TvSeason(),
        "/tvEpisode": (BuildContext context) => const TvEpisode(),
        "/movieCollections": (BuildContext context) => const MovieCollections(),
        "/addReview": (BuildContext context) => const AddReview(),
      },
    );
  }
}
