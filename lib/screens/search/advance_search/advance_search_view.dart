import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/term.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/language.dart';
import 'package:myfilmapp/model/search.dart';
import 'package:myfilmapp/screens/search/advance_search/advance_search.dart';
import 'package:myfilmapp/widgets/bottom_nav_bar.dart';
import 'package:myfilmapp/widgets/bottom_navigation_bar.dart';
import 'package:myfilmapp/widgets/button_search.dart';
import 'package:myfilmapp/widgets/list_view.dart';
import 'package:myfilmapp/widgets/list_view_horizontal.dart';

class AdvanceSearchView extends StatefulWidget {
  static const routeName = '/advanceSearchView';
  const AdvanceSearchView({Key? key}) : super(key: key);

  @override
  State<AdvanceSearchView> createState() => _AdvanceSearchViewState();
}

class _AdvanceSearchViewState extends State<AdvanceSearchView> {
  String? mediaType;
  List<dynamic> kind = [];
  double voteAverageGte = 0;
  double voteCountGte = 0;
  String? withOriginalLanguage;
  int? releaseYear;
  List<int> releaseDecade = [];
  List<int> runTimes = [];
  @override
  Widget build(BuildContext context) {
    Term.releaseYears.sort((a, b) => b.compareTo(a));
    Term.releaseDecades.sort((a, b) => b.compareTo(a));
    return Scaffold(
      backgroundColor: MyFilmAppColors.body,
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          ListViewHorizontal(
            title: "Kiểu phim",
            height: 40,
            items: Term.type,
            between: 10,
            padding: const EdgeInsets.only(left: 10.0),
            myItemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (mediaType == null ||
                          mediaType == "" ||
                          mediaType != Term.type[index]["media_type"]) {
                        mediaType = Term.type[index]["media_type"];
                      } else {
                        mediaType = "";
                      }
                    });
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.only(top: 5, bottom: 5)),
                    backgroundColor: MaterialStateProperty.all(
                      (mediaType == Term.type[index]["media_type"])
                          ? MyFilmAppColors.submain
                          : const Color(0xFF4F4F4F),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        // Change your radius here
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Center(
                      child: Text(
                        Term.type[index]["title"] ?? "",
                        style: const TextStyle(
                          color: MyFilmAppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ListViewHorizontal(
            title: "Thể loại",
            height: 40,
            items: Term.genres,
            between: 10,
            padding: const EdgeInsets.only(left: 10.0),
            myItemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (kind
                          .where((element) =>
                              element["name"] == Term.genres[index]["name"])
                          .isEmpty) {
                        kind.add(Term.genres[index]);
                      } else {
                        kind.remove(Term.genres[index]);
                      }
                    });
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.only(top: 5, bottom: 5)),
                    backgroundColor: MaterialStateProperty.all(
                      (kind
                              .where((element) =>
                                  element["name"] == Term.genres[index]["name"])
                              .isNotEmpty)
                          ? MyFilmAppColors.submain
                          : const Color(0xFF4F4F4F),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        // Change your radius here
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Center(
                      child: Text(
                        Term.genres[index]["name"] ?? "",
                        style: const TextStyle(
                          color: MyFilmAppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          // Row(
          // shrinkWrap: true,
          // scrollDirection: Axis.horizontal,
          // children: [
          ListViewHorizontal(
            title: "Điểm số",
            height: 40,
            items: Term.rates,
            between: 10,
            padding: const EdgeInsets.only(left: 10.0),
            myItemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (voteAverageGte == null ||
                          voteAverageGte != Term.rates[index]["rate"]) {
                        voteAverageGte = Term.rates[index]["rate"];
                      } else {
                        voteAverageGte = 0.0;
                      }
                    });
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.only(top: 5, bottom: 5)),
                    backgroundColor: MaterialStateProperty.all(
                      (voteAverageGte == Term.rates[index]["rate"])
                          ? MyFilmAppColors.submain
                          : const Color(0xFF4F4F4F),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        // Change your radius here
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Center(
                      child: Text(
                        Term.rates[index]["name"] ?? "",
                        style: const TextStyle(
                          color: MyFilmAppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ListViewHorizontal(
            title: "Lượng đánh giá",
            height: 40,
            items: Term.rateCounts,
            between: 10,
            padding: const EdgeInsets.only(left: 10.0),
            myItemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (voteCountGte == null ||
                          voteCountGte != Term.rateCounts[index]["count"]) {
                        voteCountGte = Term.rateCounts[index]["count"];
                      } else {
                        voteCountGte = 0.0;
                      }
                    });
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.only(top: 5, bottom: 5)),
                    backgroundColor: MaterialStateProperty.all(
                      (voteCountGte == Term.rateCounts[index]["count"])
                          ? MyFilmAppColors.submain
                          : const Color(0xFF4F4F4F),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        // Change your radius here
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Center(
                      child: Text(
                        Term.rateCounts[index]["name"] ?? "",
                        style: const TextStyle(
                          color: MyFilmAppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ListViewHorizontal(
            title: "Thập niên",
            height: 40,
            items: Term.releaseDecades,
            between: 10,
            padding: const EdgeInsets.only(left: 10.0),
            myItemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (releaseDecade
                          .where((element) =>
                              element == Term.releaseDecades[index])
                          .isEmpty) {
                        releaseDecade.add(Term.releaseDecades[index]);
                        releaseDecade.sort();
                        for (int i = releaseDecade.first + 10;
                            i < releaseDecade.last;
                            i = i + 10) {
                          if (releaseDecade
                              .where((element) => element == i)
                              .isEmpty) {
                            releaseDecade.add(i);
                          }
                          releaseDecade.sort();
                        }
                      } else {
                        releaseDecade.sort();
                        if (Term.releaseDecades[index] != releaseDecade.last) {
                          if (releaseDecade.length > 2) {
                            for (int i = releaseDecade.first;
                                i <= Term.releaseDecades[index];
                                i = i + 10) {
                              releaseDecade.remove(i);
                              // releaseDecade.sort();
                            }
                          } else {
                            releaseDecade.remove(Term.releaseDecades[index]);
                          }
                        } else {
                          releaseDecade.remove(Term.releaseDecades[index]);
                        }
                      }
                    });
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.only(top: 5, bottom: 5)),
                    backgroundColor: MaterialStateProperty.all(
                      (releaseDecade
                              .where((element) =>
                                  element == Term.releaseDecades[index])
                              .isNotEmpty)
                          ? MyFilmAppColors.submain
                          : const Color(0xFF4F4F4F),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        // Change your radius here
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Center(
                      child: Text(
                        "${Term.releaseDecades[index]} 's",
                        style: const TextStyle(
                          color: MyFilmAppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ListViewHorizontal(
            title: "Năm phát hành",
            height: 40,
            items: Term.releaseYears,
            between: 10,
            padding: const EdgeInsets.only(left: 10.0),
            myItemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (releaseYear == null ||
                          releaseYear != Term.releaseYears[index]) {
                        releaseYear = Term.releaseYears[index];
                      } else {
                        releaseYear = 0;
                      }
                    });
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.only(top: 5, bottom: 5)),
                    backgroundColor: MaterialStateProperty.all(
                      (releaseYear == Term.releaseYears[index])
                          ? MyFilmAppColors.submain
                          : const Color(0xFF4F4F4F),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        // Change your radius here
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Center(
                      child: Text(
                        "${Term.releaseYears[index]}",
                        style: const TextStyle(
                          color: MyFilmAppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // ],
          // ),
          const SizedBox(
            height: 15,
          ),
          MyListView(
            future: TheMovieDbClient().fetchLanguageResults(
              "configuration/languages?api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            listBuilder: (snapshot) => snapshot.data!.items,
            myItemBuilder: (items) {
              List<Language> languages = [];
              if (items != null) {
                languages = items.cast<Language>();
              }
              languages.sort((a, b) => a.englishName.compareTo(b.englishName));
              return ListViewHorizontal(
                title: "Ngôn ngữ chính",
                height: 40,
                items: languages,
                between: 10,
                padding: const EdgeInsets.only(left: 10.0),
                myItemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (withOriginalLanguage == null ||
                              withOriginalLanguage !=
                                  languages[index].iso_639_1) {
                            withOriginalLanguage = languages[index].iso_639_1;
                          } else {
                            withOriginalLanguage = "";
                          }
                        });
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(top: 5, bottom: 5)),
                        backgroundColor: MaterialStateProperty.all(
                          (withOriginalLanguage == languages[index].iso_639_1)
                              ? MyFilmAppColors.submain
                              : const Color(0xFF4F4F4F),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            // Change your radius here
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Center(
                          child: Text(
                            languages[index].englishName,
                            style: const TextStyle(
                              color: MyFilmAppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ListViewHorizontal(
            title: "Thời lượng",
            height: 40,
            items: Term.runTimes,
            between: 10,
            padding: const EdgeInsets.only(left: 10.0),
            myItemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (runTimes
                          .where((element) => element == index + 1)
                          .isEmpty) {
                        runTimes.add(index + 1);
                        runTimes.sort();
                        for (int i = runTimes.first + 1;
                            i < runTimes.last;
                            i = i + 1) {
                          if (runTimes
                              .where((element) => element == i)
                              .isEmpty) {
                            runTimes.add(i);
                          }
                          runTimes.sort();
                        }
                      } else {
                        runTimes.sort();
                        if (index + 1 != runTimes.last) {
                          if (runTimes.length > 2) {
                            for (int i = runTimes.first;
                                i <= index + 1;
                                i = i + 1) {
                              runTimes.remove(i);
                              // runTimes.sort();
                            }
                          } else {
                            runTimes.remove(index + 1);
                          }
                        } else {
                          runTimes.remove(index + 1);
                        }
                      }
                    });
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.only(top: 5, bottom: 5)),
                    backgroundColor: MaterialStateProperty.all(
                      (runTimes
                              .where((element) => element == index + 1)
                              .isNotEmpty)
                          ? MyFilmAppColors.submain
                          : const Color(0xFF4F4F4F),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        // Change your radius here
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Center(
                      child: Text(
                        "${Term.runTimes[index]["name"]}",
                        style: const TextStyle(
                          color: MyFilmAppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(runTimes);
          List<int> withRuntime = [];
          if (runTimes.isNotEmpty) {
            for (var element in runTimes) {
              for (var item in Term.runTimes[element - 1]["range"]) {
                if (withRuntime.where((element) => element == item).isEmpty) {
                  withRuntime.add(item);
                }
              }
            }
          }
          withRuntime.sort();
          print((withRuntime.first == 0) ? 1 : withRuntime.first * 60);
          if (mediaType != null) {
            String withGenres = "";
            if (kind.isNotEmpty) {
              for (var i = 0; i < kind.length; i++) {
                if (i == kind.length - 1) {
                  withGenres += "${kind[i]["id"]["$mediaType"]}";
                } else {
                  withGenres += "${kind[i]["id"]["$mediaType"]} , ";
                }
              }
            }
            Navigator.pushNamed(
              context,
              AdvanceSearch.routeName,
              arguments: MySearch(
                mediaType: mediaType,
                withGenres: withGenres,
                voteAverageGte: voteAverageGte,
                voteCountGte: voteCountGte,
                primaryReleaseYear: "$releaseYear",
                firstAirDateYear: "$releaseYear",
                firstAirDateGte: (releaseDecade.isNotEmpty)
                    ? "${releaseDecade.first}-01-01"
                    : "",
                firstAirDateLte: (releaseDecade.isNotEmpty)
                    ? "${releaseDecade.last}-12-31"
                    : "",
                primaryReleaseDateGte: (releaseDecade.isNotEmpty)
                    ? "${releaseDecade.first}-01-01"
                    : "",
                primaryReleaseDateLte: (releaseDecade.isNotEmpty)
                    ? "${releaseDecade.last}-12-31"
                    : "",
                withOriginalLanguage: withOriginalLanguage,
                withRuntimeGte: (withRuntime.isNotEmpty)
                    ? (withRuntime.first == 0)
                        ? 1
                        : withRuntime.first * 60
                    : 0,
                withRuntimeLte: (withRuntime.isNotEmpty)
                    ? (withRuntime.last == 0)
                        ? 1
                        : withRuntime.last * 60
                    : 0,
              ),
            );
          }
        },
        tooltip: 'Tìm kiếm',
        backgroundColor: MyFilmAppColors.submain,
        child: SizedBox(
          width: 28,
          child: SvgPicture.asset(
            'assets/images/advance_search_outline.svg',
            width: 28,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}
