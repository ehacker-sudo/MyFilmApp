import 'package:flutter/material.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/episode.dart';
import 'package:myfilmapp/model/season.dart';
import 'package:myfilmapp/screens/detail/episode_detail.dart';
import 'package:myfilmapp/widgets/bottom_navigation_bar.dart';
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
    return Theme(
      data: ThemeData(
          // brightness: Brightness.dark,
          ),
      child: Scaffold(
        // backgroundColor: MyFilmAppColors.body,
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          backButton: true,
          title: args.name,
        ),
        body: Container(
          color: MyFilmAppColors.body,
          child: ListView(
            // decoration: const BoxDecoration(color: MyFilmAppColors.body),
            children: [
              FutureBuilder<Season>(
                future: TheMovieDbClient().fetchSeasonResults(
                  "tv/${args.seriesId}/season/${args.seasonNumber}?api_key=7bb0f209157f0bb4788ecb54be635d14",
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final episodes = snapshot.data!.episodes;
                    return ListView.builder(
                      itemCount: episodes.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        episodes[index].seriesId = args.seriesId;
                        return Container(
                          padding: const EdgeInsets.only(
                            left: 5.0,
                            right: 5.0,
                            bottom: 15.0,
                          ),
                          child: CardHorizontal(
                            name: episodes[index].name,
                            backdropPath: episodes[index].stillPath,
                            overview: episodes[index].overview,
                            airDate: episodes[index].airDate,
                            voteAverage: episodes[index].voteAverage,
                            episodeCount: episodes[index].runtime,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                EpisodeDetail.routeName,
                                arguments: episodes[index],
                              );
                            },
                          ),
                        );
                      },
                    );
                    // } else if (snapshot.hasError) {
                    //   return Text(
                    //     '${snapshot.error}',
                    //     style: const TextStyle(color: MyFilmAppColors.white),
                    //   );
                  }

                  // By default, show a loading spinner.
                  return const Column(
                    children: [CircularProgressIndicator()],
                  );
                },
              ),
              Expanded(
                child: Container(
                  color: MyFilmAppColors.body,
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const MyBottomNavigationBar(),
      ),
    );
  }
}
