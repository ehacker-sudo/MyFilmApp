import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/detail/episode_detail.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/screens/detail/person_detail.dart';
import 'package:myfilmapp/screens/form/add_review.dart';
import 'package:myfilmapp/screens/home/home.dart';
import 'package:myfilmapp/screens/search/search/github_client.dart';
import 'package:myfilmapp/screens/search/search/search_middleware.dart';
import 'package:myfilmapp/screens/search/search/search_reducer.dart';
import 'package:myfilmapp/screens/search/search/search_state.dart';
import 'package:myfilmapp/screens/season/movie_collections.dart';
import 'package:myfilmapp/screens/season/tv_episode.dart';
import 'package:myfilmapp/screens/season/tv_season.dart';
// import 'package:myfilmapp/screens/movie/movie.dart';
// import 'package:myfilmapp/screens/tv/tv.dart';

import 'package:redux/redux.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: MyFilmAppColors.header,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  final store = Store<SearchState>(
    searchReducer,
    initialState: SearchInitial(),
    middleware: [
      // The following middleware both achieve the same goal: Load search
      // results from github in response to SearchActions.
      //
      // One is implemented as a normal middleware, the other is implemented as
      // an epic for demonstration purposes.

      SearchMiddleware(GithubClient()),
      // EpicMiddleware<SearchState>(SearchEpic(GithubClient())),
    ],
  );

  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<SearchState> store;

  const MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
        GlobalKey<ScaffoldMessengerState>();
    return StoreProvider<SearchState>(
      store: store,
      child: MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        title: 'Film App',
        // theme: ThemeData(
        //   brightness: Brightness.dark,
        // ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => const Home(),
          '/filmDetail': (BuildContext context) => const FilmDetail(),
          "/episodeDetail": (BuildContext context) => const EpisodeDetail(),
          "/personDetail": (BuildContext context) => const PersonDetail(),
          "/tvSeason": (BuildContext context) => const TvSeason(),
          "/tvEpisode": (BuildContext context) => const TvEpisode(),
          "/movieCollections": (BuildContext context) =>
              const MovieCollections(),
          "/addReview": (BuildContext context) => const AddReview(),
        },
      ),
    );
  }
}
