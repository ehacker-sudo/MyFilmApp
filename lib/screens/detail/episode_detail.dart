import 'package:flutter/material.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/episode.dart';
import 'package:myfilmapp/model/external_id.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/image.dart';
import 'package:myfilmapp/model/person.dart';
import 'package:myfilmapp/widgets/card_credit.dart';
import 'package:myfilmapp/widgets/item_external_source.dart';
import 'package:myfilmapp/widgets/navbar.dart';
import 'package:myfilmapp/database/database.dart';
import 'package:myfilmapp/widgets/star_rating_modal.dart';
import 'package:star_rating/star_rating.dart';

class EpisodeDetail extends StatefulWidget {
  static const routeName = '/episodeDetail';
  const EpisodeDetail({Key? key}) : super(key: key);

  @override
  State<EpisodeDetail> createState() => _EpisodeDetailState();
}

class _EpisodeDetailState extends State<EpisodeDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // MyFilmAppDatabase().historyStore();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Episode;
    // print(
    //     "tv/${args.seriesId}/season/${args.seasonNumber}/episode/${args.episodeNumber}");
    return Scaffold(
      backgroundColor: MyFilmAppColors.body,
      appBar: Navbar(
        backButton: true,
        title: args.name,
      ),
      body: FutureBuilder<Episode>(
        future: TheMovieDbClient().fetchEpisodeResults(
          "tv/${args.seriesId}/season/${args.seasonNumber}/episode/${args.episodeNumber}?api_key=7bb0f209157f0bb4788ecb54be635d14",
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final episode = snapshot.data as Episode;
            episode.seriesId = args.seriesId;
            print(
                "tv/${episode.seriesId}/season/${episode.seasonNumber}/episode/${episode.episodeNumber}/credits?api_key=7bb0f209157f0bb4788ecb54be635d14");
            return SizedBox.expand(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(color: MyFilmAppColors.body),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/original${episode.stillPath}",
                                height: 250 * 790 / 500,
                                width: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.center,
                            margin: const EdgeInsets.only(top: 30),
                            child: Text(
                              episode.name,
                              style: const TextStyle(
                                  color: MyFilmAppColors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "${episode.voteAverage}",
                              style: const TextStyle(
                                color: MyFilmAppColors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.center,
                            child: StarRating(
                              mainAxisAlignment: MainAxisAlignment.center,
                              length: 10,
                              rating: episode.voteAverage,
                              between: 4,
                              starSize: 25,
                              color: MyFilmAppColors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Thời lượng",
                                  style: TextStyle(
                                    color: MyFilmAppColors.gray,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${episode.runtime} m",
                                  style: const TextStyle(
                                    color: MyFilmAppColors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ],
                            ),
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     const Text(
                            //       "Ngôn ngữ",
                            //       style: TextStyle(
                            //         color: MyFilmAppColors.gray,
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //     Text(
                            //       film.originalLanguage,
                            //       style: const TextStyle(
                            //         color: MyFilmAppColors.white,
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.w500,
                            //         letterSpacing: 0,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Năm phát hành",
                                  style: TextStyle(
                                    color: MyFilmAppColors.gray,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  (episode.airDate == "")
                                      ? ""
                                      : episode.airDate.substring(0, 4),
                                  style: const TextStyle(
                                    color: MyFilmAppColors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Giới thiệu phim",
                              style: TextStyle(
                                  color: MyFilmAppColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              episode.overview,
                              style: const TextStyle(
                                  color: MyFilmAppColors.longText),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Đánh giá phim",
                              style: TextStyle(
                                color: MyFilmAppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const StarRatingModal();
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.star_border_outlined,
                                color: MyFilmAppColors.submain,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 10.0,
                                    bottom: 10.0),
                                child: const Text(
                                  "Diễn viên",
                                  style: TextStyle(
                                      color: MyFilmAppColors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          FutureBuilder<ListCredit>(
                            future: TheMovieDbClient().fetchCreditResults(
                              "tv/${episode.seriesId}/season/${episode.seasonNumber}/episode/${episode.episodeNumber}/credits?api_key=7bb0f209157f0bb4788ecb54be635d14",
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final casts =
                                    snapshot.data?.listCast as List<Person>;
                                return SizedBox(
                                  height: 310,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return CardCredit(
                                        person: casts[index],
                                      );
                                    },
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  '${snapshot.error}',
                                  style: const TextStyle(
                                      color: MyFilmAppColors.white),
                                );
                              }

                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder<ListImage>(
                        future: TheMovieDbClient().fetchImageResults(
                          "tv/${episode.seriesId}/season/${episode.seasonNumber}/episode/${episode.episodeNumber}/images?language=en&api_key=7bb0f209157f0bb4788ecb54be635d14",
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final stills =
                                snapshot.data?.listStills as List<ImageModel>;
                            if (stills.isNotEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          top: 10.0,
                                          bottom: 10.0,
                                        ),
                                        child: const Text(
                                          "Tập ảnh",
                                          style: TextStyle(
                                            color: MyFilmAppColors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 150,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: stills.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: 150 *
                                                  stills[index].aspectRatio,
                                              margin: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Image.network(
                                                "https://image.tmdb.org/t/p/original${stills[index].filePath}",
                                                height: 150,
                                                width: 150 *
                                                    stills[index].aspectRatio,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          } else if (snapshot.hasError) {
                            return Text(
                              '${snapshot.error}',
                              style: const TextStyle(
                                color: MyFilmAppColors.white,
                              ),
                            );
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 10.0,
                                    bottom: 10.0),
                                child: const Text(
                                  "Khám giá thêm",
                                  style: TextStyle(
                                      color: MyFilmAppColors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          FutureBuilder<ExternalId>(
                            future: TheMovieDbClient().fetchExternalIdResults(
                                "tv/${episode.seriesId}/season/${episode.seasonNumber}/episode/${episode.episodeNumber}/external_ids?api_key=7bb0f209157f0bb4788ecb54be635d14"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final externalIdFilm =
                                    snapshot.data as ExternalId;
                                return SizedBox(
                                  height: 50.0 * externalIdFilm.total,
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      if (externalIdFilm.imdbId != "")
                                        ItemExternalSource(
                                          name: "Imdb",
                                          externalId: externalIdFilm.imdbId,
                                        ),
                                      if (externalIdFilm.facebookId != "")
                                        ItemExternalSource(
                                          name: "Facebook",
                                          externalId: externalIdFilm.facebookId,
                                        ),
                                      if (externalIdFilm.instagramId != "")
                                        ItemExternalSource(
                                          name: "Instagram",
                                          externalId:
                                              externalIdFilm.instagramId,
                                        ),
                                      if (externalIdFilm.twitterId != "")
                                        ItemExternalSource(
                                          name: "Twitter",
                                          externalId: externalIdFilm.twitterId,
                                        ),
                                      if (externalIdFilm.wikidataId != "")
                                        ItemExternalSource(
                                          name: "Wikidata",
                                          externalId: externalIdFilm.wikidataId,
                                        ),
                                    ],
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  '${snapshot.error}',
                                  style: const TextStyle(
                                      color: MyFilmAppColors.white),
                                );
                              }

                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
    );
  }
}
