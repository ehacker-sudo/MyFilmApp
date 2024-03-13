import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/screens/season/tv_episode.dart';
import 'package:myfilmapp/widgets/card_horizontal.dart';
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

    return Scaffold(
      appBar: Navbar(
        backButton: true,
        title: "${args.name}${args.title}",
      ),
      body: Container(
        decoration: const BoxDecoration(color: MyFilmAppColors.body),
        child: ListView(
          children: [
            ListView.builder(
              itemCount: args.seasons.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (content, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: CardHorizontal(
                    name: args.seasons[index].name,
                    backdropPath: args.seasons[index].posterPath,
                    overview: args.seasons[index].overview,
                    airDate: args.seasons[index].airDate,
                    episodeCount: args.seasons[index].episodeCount,
                    voteAverage: args.seasons[index].voteAverage,
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
          ],
        ),
      ),
    );
  }
}
