import 'package:flutter/material.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/episode.dart';
import 'package:myfilmapp/model/season.dart';
import 'package:myfilmapp/screens/detail/episode_detail.dart';
import 'package:myfilmapp/widgets/card_horizontal.dart';
import 'package:myfilmapp/widgets/navbar.dart';

class TvEpisode extends StatefulWidget {
  static const routeName = '/tvEpisode';
  const TvEpisode({Key? key}) : super(key: key);

  @override
  State<TvEpisode> createState() => _TvEpisodeState();
}

class _TvEpisodeState extends State<TvEpisode> {
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Season;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        backButton: true,
        title: args.name,
      ),
      body: Container(
        decoration: const BoxDecoration(color: MyFilmAppColors.body),
        child: ListView(
          children: [
            FutureBuilder<Season>(
              future: TheMovieDbClient().fetchSeasonResults(
                "tv/${args.seriesId}/season/${args.seasonNumber}?api_key=7bb0f209157f0bb4788ecb54be635d14",
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final episodes = snapshot.data!.episodes;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: episodes.length,
                    itemBuilder: (context, index) {
                      episodes[index].seriesId = args.seriesId;
                      return CardHorizontal(
                        name: episodes[index].name,
                        backdropPath: episodes[index].stillPath,
                        overview: episodes[index].overview,
                        airDate: episodes[index].airDate,
                        voteAverage: episodes[index].voteAverage,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            EpisodeDetail.routeName,
                            arguments: episodes[index],
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: const TextStyle(color: MyFilmAppColors.white),
                  );
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
