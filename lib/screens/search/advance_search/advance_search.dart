import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/search.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/widgets/card_vertical.dart';
import 'package:myfilmapp/widgets/loadmore.dart';
import 'package:myfilmapp/widgets/navbar.dart';

class AdvanceSearch extends StatefulWidget {
  static const routeName = '/advanceSearch';
  const AdvanceSearch({Key? key}) : super(key: key);

  @override
  State<AdvanceSearch> createState() => _AdvanceSearchState();
}

class _AdvanceSearchState extends State<AdvanceSearch> {
  final String baseUrl = 'https://api.themoviedb.org/3/';

  List<Film> listItem = [];
  int _currentPage = 1;
  int _totalResults = 21;

  int get count => listItem.length;

  Future<void> _fetchResults(String term, int currentPage) async {
    debugPrint("waiting");
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term&page=$currentPage',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      List<Map<String, dynamic>> keywords;
      List<Map<String, dynamic>> items;
      List<Map<String, dynamic>> casts;
      keywords = items = casts = [];
      if (results['total_results'] != null) {
        setState(() {
          _totalResults = results['total_results'] ?? 20;
        });
      }
      if (results['results'] != null) {
        items = (results['results'] as List).cast<Map<String, dynamic>>();
      }
      // return ListFilm.fromJson(items, casts, keywords);
      ListFilm listFilm = ListFilm.fromJson(items, casts, keywords);
      setState(() {
        listItem.addAll(listFilm.items);
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
    debugPrint("done");
  }

  Future<void> _fetchTotalResults(String term, int currentPage) async {
    debugPrint("waiting");
    final response = await http.get(
      Uri.parse(
        '$baseUrl$term&page=$currentPage',
      ),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      if (results['total_results'] != null) {
        setState(() {
          _totalResults = results['total_results'] ?? 1;
        });
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Film');
    }
    debugPrint("done");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
    String queryString =
        "discover/${args.mediaType}?language=en-US&api_key=7bb0f209157f0bb4788ecb54be635d14$voteAverageGte$withKeywords$withGenres$voteCountGte$releaseYear$releaseTime$withOriginalLanguage$runTime";

    Future<bool> loadMore() async {
      await Future.delayed(const Duration(milliseconds: 300));
      await _fetchResults(queryString, _currentPage++);
      await Future.delayed(const Duration(milliseconds: 100));
      return true;
    }

    Future<void> refresh() async {
      await Future.delayed(const Duration(milliseconds: 250));
      listItem.clear();
      await _fetchResults(queryString, 1);
    }

    return Scaffold(
      backgroundColor: MyFilmAppColors.body,
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        backButton: true,
        title: "Tìm kiếm",
      ),
      body: Container(
        color: const Color(0xFF3C3C3C).withOpacity(0.2),
        child: ScrollbarTheme(
          data: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(
              Colors.grey,
            ),
          ),
          child: RefreshIndicator(
            onRefresh: refresh,
            child: LoadMore(
              isFinish: (_totalResults > 5000)
                  ? count >= 5000
                  : count >= _totalResults,
              onLoadMore: loadMore,
              whenEmptyLoad: true,
              delegate: const DefaultLoadMoreDelegate(),
              textBuilder: DefaultLoadMoreTextBuilder.vietnamese,
              child: ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {
                  final item = listItem[index];
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
