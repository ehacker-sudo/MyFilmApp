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
                "discover/${args.mediaType}?language=en-US&page=1&with_keywords=${args.withGenres}&with_keywords=${args.withKeywords}&api_key=7bb0f209157f0bb4788ecb54be635d14",
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
