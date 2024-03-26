import 'package:flutter/material.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/person.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/screens/detail/person_detail.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';
import 'package:myfilmapp/widgets/card_horizontal.dart';
import 'package:myfilmapp/widgets/card_vertical.dart';
import 'package:myfilmapp/widgets/navbar.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyFilmAppColors.body,
      appBar: Navbar(
        backButton: true,
        searchBar: true,
        onSubmit: (text) {
          setState(() {
            searchText = text;
          });
        },
      ),
      body: Container(
        decoration: const BoxDecoration(color: MyFilmAppColors.body),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   padding: const EdgeInsets.only(left: 15, bottom: 10),
                //   child: const Text(
                //     "Đề xuât",
                //     style: TextStyle(
                //       color: MyFilmAppColors.white,
                //       fontSize: 20,
                //       fontWeight: FontWeight.w400,
                //     ),
                //   ),
                // ),
                FutureBuilder<ListFilm>(
                  future: TheMovieDbClient().fetchResults(
                      "search/multi?page=1&api_key=7bb0f209157f0bb4788ecb54be635d14&query=$searchText"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final searchResult = snapshot.data!.items;
                      return ListView.builder(
                        itemCount: searchResult.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (content, index) {
                          if (searchResult[index].mediaType == "person") {
                            Person person = Person(
                              id: searchResult[index].id,
                              name: searchResult[index].name,
                              profilePath: searchResult[index].profilePath,
                            );
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: CardVertical(
                                name: person.name,
                                posterPath: person.profilePath,
                                // backdropPath: args.seasons[index].posterPath,
                                // overview: args.seasons[index].overview,
                                // airDate: args.seasons[index].airDate,
                                // episodeCount: args.seasons[index].episodeCount,
                                // voteAverage: args.seasons[index].voteAverage,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    PersonDetail.routeName,
                                    arguments: person,
                                  );
                                },
                              ),
                            );
                          } else {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: CardVertical(
                                name:
                                    "${searchResult[index].name}${searchResult[index].title}",
                                posterPath: searchResult[index].posterPath,
                                // backdropPath: args.seasons[index].posterPath,
                                // overview: args.seasons[index].overview,
                                // airDate: args.seasons[index].airDate,
                                // episodeCount: args.seasons[index].episodeCount,
                                // voteAverage: args.seasons[index].voteAverage,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    FilmDetail.routeName,
                                    arguments: searchResult[index],
                                  );
                                },
                              ),
                            );
                          }
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
            )
          ],
        ),
      ),
    );
  }
}
