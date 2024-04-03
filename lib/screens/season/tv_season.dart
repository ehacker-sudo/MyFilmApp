import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/screens/season/tv_episode.dart';
import 'package:myfilmapp/widgets/bottom_navigation_bar.dart';
import 'package:myfilmapp/widgets/card_horizontal.dart';
import 'package:myfilmapp/widgets/card_vertical.dart';
import 'package:myfilmapp/widgets/navbar.dart';

class TvSeason extends StatefulWidget {
  static const routeName = '/tvSeason';
  const TvSeason({super.key});

  @override
  State<TvSeason> createState() => _TvSeasonState();
}

class _TvSeasonState extends State<TvSeason> {
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Film;

    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          backButton: true,
          title: "${args.name}${args.title}",
        ),
        body: ListView.builder(
          itemCount: args.seasons.length,
          itemBuilder: (content, index) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              child: CardVertical(
                name: args.seasons[index].name,
                posterPath: args.seasons[index].posterPath,
                overview: args.seasons[index].overview,
                airDate: args.seasons[index].airDate,
                episodeCount: args.seasons[index].episodeCount,
                voteAverage: args.seasons[index].voteAverage,
                mediaType: "season",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TvEpisode.routeName,
                    arguments: args.seasons[index],
                  );
                },
              ),
            );
          },
        ),
        bottomNavigationBar: const MyBottomNavigationBar(),
      ),
    );
  }
}
