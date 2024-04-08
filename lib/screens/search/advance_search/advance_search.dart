import 'package:flutter/material.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/person.dart';
import 'package:myfilmapp/model/search.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/screens/detail/person_detail.dart';
import 'package:myfilmapp/widgets/card_vertical.dart';
import 'package:myfilmapp/widgets/navbar.dart';

class AdvanceSearch extends StatefulWidget {
  static const routeName = '/advanceSearch';
  const AdvanceSearch({Key? key}) : super(key: key);

  @override
  State<AdvanceSearch> createState() => _AdvanceSearchState();
}

class _AdvanceSearchState extends State<AdvanceSearch> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MySearch;
    String withKeywords =
        (args.withKeywords == "") ? "" : "&with_keywords=${args.withKeywords}";
    String withGenres =
        (args.withGenres == "") ? "" : "&with_genres=${args.withGenres}";
    String voteAverageGte = (args.voteAverageGte == 0)
        ? ""
        : "&vote_average.gte=${args.voteAverageGte}";

    String voteCountGte =
        (args.voteCountGte == 0) ? "" : "&vote_count.gte=${args.voteCountGte}";

    String runTime = (args.withRuntimeGte == 0 || args.withRuntimeLte == 0)
        ? ""
        : "&with_runtime.gte=${args.withRuntimeGte}&with_runtime.lte=${args.withRuntimeLte}";
    String withOriginalLanguage = (args.withOriginalLanguage == "")
        ? ""
        : "&with_original_language=${args.withOriginalLanguage}";

    String releaseYear = (args.mediaType == "tv")
        ? (args.firstAirDateYear == "")
            ? ""
            : "&first_air_date_year=${args.firstAirDateYear}"
        : (args.primaryReleaseYear == "")
            ? ""
            : "&primary_release_year=${args.primaryReleaseYear}";
    String releaseTime = (args.mediaType == "tv")
        ? (args.firstAirDateGte == "" || args.firstAirDateLte == "")
            ? ""
            : "&first_air_date.gte=${args.firstAirDateGte}&first_air_date.lte=${args.firstAirDateLte}"
        : (args.primaryReleaseDateGte == "" || args.primaryReleaseDateLte == "")
            ? ""
            : "&primary_release_date.gte=${args.primaryReleaseDateGte}&primary_release_date.lte=${args.primaryReleaseDateLte}";
    return Scaffold(
      backgroundColor: MyFilmAppColors.body,
      appBar: Navbar(
        backButton: true,
        title: "Tìm kiếm",
      ),
      body: Flex(direction: Axis.vertical, children: <Widget>[
        Expanded(
          child: Container(
            color: const Color(0xFF3C3C3C).withOpacity(0.2),
            child: FutureBuilder(
              future: TheMovieDbClient().fetchResults(
                "discover/${args.mediaType}?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14$voteAverageGte$withKeywords$withGenres$voteCountGte$releaseYear$releaseTime$withOriginalLanguage$runTime",
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List items = snapshot.data!.items;
                  if (items.isNotEmpty) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Container(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5.0, bottom: 5.0),
                          child: CardVertical(
                            id: item.id,
                            name: '${item.name}${item.title}',
                            mediaType: item.mediaType,
                            posterPath: item.posterPath,
                            airDate: '${item.firstAirDate}${item.releaseDate}',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                FilmDetail.routeName,
                                arguments: item,
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox(
                      height: 15,
                    );
                  }
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
          ),
        )
      ]),
    );
  }
}
