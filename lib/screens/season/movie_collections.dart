import 'package:flutter/material.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/collection.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/screens/season/tv_episode.dart';
import 'package:myfilmapp/widgets/bottom_navigation_bar.dart';
import 'package:myfilmapp/widgets/card_horizontal.dart';
import 'package:myfilmapp/widgets/navbar.dart';

class MovieCollections extends StatefulWidget {
  static const routeName = '/movieCollections';
  const MovieCollections({super.key});

  @override
  State<MovieCollections> createState() => _MovieCollectionsState();
}

class _MovieCollectionsState extends State<MovieCollections> {
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Film;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        backButton: true,
        title: "${args.name}${args.title}",
      ),
      body: Container(
        decoration: const BoxDecoration(color: MyFilmAppColors.body),
        child: ListView(
          children: [
            FutureBuilder<Collection>(
              future: TheMovieDbClient().fetchColectionResults(
                "collection/${args.belongsToCollection.id}?api_key=7bb0f209157f0bb4788ecb54be635d14",
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final parts = snapshot.data!.parts;
                  print(args.belongsToCollection.id);
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: parts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          right: 5.0,
                          bottom: 15.0,
                        ),
                        child: CardHorizontal(
                          name: parts[index].name,
                          backdropPath: parts[index].backdropPath,
                          overview: parts[index].overview,
                          airDate: parts[index].releaseDate,
                          voteAverage: parts[index].voteAverage,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              FilmDetail.routeName,
                              arguments: parts[index],
                            );
                          },
                        ),
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
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
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
