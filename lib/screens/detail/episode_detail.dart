import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/api/user_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/auth.dart';
import 'package:myfilmapp/model/episode.dart';
import 'package:myfilmapp/model/external_id.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/image.dart';
import 'package:myfilmapp/model/person.dart';
import 'package:myfilmapp/model/review.dart';
import 'package:myfilmapp/model/user.dart';
import 'package:myfilmapp/screens/form/add_review.dart';
import 'package:myfilmapp/widgets/bottom_navigation_bar.dart';
import 'package:myfilmapp/widgets/button_watchlist.dart';
import 'package:myfilmapp/widgets/card_credit.dart';
import 'package:myfilmapp/widgets/item_external_source.dart';
import 'package:myfilmapp/widgets/navbar.dart';
import 'package:myfilmapp/database/database.dart';
import 'package:myfilmapp/widgets/star_rating_modal.dart';
import 'package:quickalert/quickalert.dart';
import 'package:star_rating/star_rating.dart';

class EpisodeDetail extends StatefulWidget {
  static const routeName = '/episodeDetail';
  const EpisodeDetail({Key? key}) : super(key: key);

  @override
  State<EpisodeDetail> createState() => _EpisodeDetailState();
}

class _EpisodeDetailState extends State<EpisodeDetail> {
  late Future<User> _futureUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // MyFilmAppDatabase().historyStore();
    _futureUser = AdminClient().loginUser();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Episode;
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
                                fontWeight: FontWeight.w400,
                              ),
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
                        margin: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        child: ButtonWatchlist(
                          member: Member(
                            mediaType: "episode",
                            episode: episode,
                          ),
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
                            MyStarRating(
                              member: Member(
                                mediaType: "episode",
                                episode: episode,
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
                                      return Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: CardCredit(
                                          person: casts[index],
                                        ),
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
                                    ],
                                  ),
                                  SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: stills.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width:
                                              150 * stills[index].aspectRatio,
                                          margin:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Image.network(
                                            "https://image.tmdb.org/t/p/original${stills[index].filePath}",
                                            height: 150,
                                            width:
                                                150 * stills[index].aspectRatio,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
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
                      InkWell(
                        onTap: () {
                          _futureUser.then((value) {
                            Navigator.pushNamed(
                              context,
                              AddReview.routeName,
                              arguments: Member(
                                mediaType: "episode",
                                episode: episode,
                              ),
                            );
                          }).catchError((err) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.warning,
                              text: 'Hãy đăng nhập để bình luận',
                            );
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          decoration: const BoxDecoration(
                            color: MyFilmAppColors.submain,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/plus.svg',
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Thêm bình luận",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: MyFilmAppColors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder<ListReview>(
                        future: TheMovieDbClient().fetchUserReviewResults(
                          Member(mediaType: "episode", episode: episode),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var reviews = snapshot.data?.items as List<Review>;

                            if (reviews.isNotEmpty) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 15.0,
                                            right: 15.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        child: const Text(
                                          "Bình luận phim",
                                          style: TextStyle(
                                              color: MyFilmAppColors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    height: 150,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: reviews.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 150,
                                          width: 400,
                                          color: MyFilmAppColors.header,
                                          margin: const EdgeInsets.only(
                                            left: 10.0,
                                          ),
                                          padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (reviews[index]
                                                      .authorDetails
                                                      .rating !=
                                                  0.0)
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color: MyFilmAppColors
                                                              .submain,
                                                          size: 15,
                                                        ),
                                                        const SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          "${reviews[index].authorDetails.rating.toInt() + .0}",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                MyFilmAppColors
                                                                    .white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              Text(
                                                reviews[index].content,
                                                maxLines: 5,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13.0,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          } else if (snapshot.hasError) {
                            return const SizedBox();
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
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
                                return Column(
                                  children: [
                                    if (externalIdFilm.imdbId != "")
                                      ItemExternalSource(
                                        name: "Imdb",
                                        margin: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 10.0,
                                          bottom: 0,
                                          top: 0,
                                        ),
                                        externalId: externalIdFilm.imdbId,
                                      ),
                                    if (externalIdFilm.facebookId != "")
                                      ItemExternalSource(
                                        name: "Facebook",
                                        margin: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 10.0,
                                          bottom: 0,
                                          top: 0,
                                        ),
                                        externalId: externalIdFilm.facebookId,
                                      ),
                                    if (externalIdFilm.instagramId != "")
                                      ItemExternalSource(
                                        name: "Instagram",
                                        margin: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 10.0,
                                          bottom: 0,
                                          top: 0,
                                        ),
                                        externalId: externalIdFilm.instagramId,
                                      ),
                                    if (externalIdFilm.twitterId != "")
                                      ItemExternalSource(
                                        name: "Twitter",
                                        margin: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 10.0,
                                          bottom: 0,
                                          top: 0,
                                        ),
                                        externalId: externalIdFilm.twitterId,
                                      ),
                                    if (externalIdFilm.wikidataId != "")
                                      ItemExternalSource(
                                        name: "Wikidata",
                                        margin: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 10.0,
                                          bottom: 0,
                                          top: 0,
                                        ),
                                        externalId: externalIdFilm.wikidataId,
                                      ),
                                  ],
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
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
