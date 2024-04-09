import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/api/user_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/auth.dart';
import 'package:myfilmapp/model/external_id.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/image.dart';
import 'package:myfilmapp/model/person.dart';
import 'package:myfilmapp/model/review.dart';
import 'package:myfilmapp/model/search.dart';
import 'package:myfilmapp/model/user.dart';
import 'package:myfilmapp/screens/form/add_review.dart';
import 'package:myfilmapp/screens/search/advance_search/advance_search.dart';
import 'package:myfilmapp/screens/season/movie_collections.dart';
import 'package:myfilmapp/screens/season/tv_season.dart';
import 'package:myfilmapp/widgets/button_watchlist.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';
import 'package:myfilmapp/widgets/card_credit.dart';
import 'package:myfilmapp/widgets/card_overview.dart';
import 'package:myfilmapp/widgets/card_review.dart';
import 'package:myfilmapp/widgets/item_detail.dart';
import 'package:myfilmapp/widgets/item_external_source.dart';
import 'package:myfilmapp/widgets/list_view.dart';
import 'package:myfilmapp/widgets/list_view_horizontal.dart';
import 'package:myfilmapp/widgets/outlined_button.dart';
import 'package:myfilmapp/widgets/star_rating_modal.dart';
import 'package:quickalert/quickalert.dart';
import 'package:star_rating/star_rating.dart';

class FilmMobileView extends StatelessWidget {
  final Film film;
  final Function(ConnectionState connectionState) onLoad;
  final Future<User> _futureUser = AdminClient().loginUser();
  FilmMobileView({
    super.key,
    Film? film,
    Function(ConnectionState connectionState)? onLoad,
  })  : film = film ?? Film(),
        onLoad = onLoad ?? defaultOnLoad;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: AlignmentDirectional.topCenter,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Hero(
              tag: film.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: (film.posterPath != "")
                    ? Image.network(
                        "https://image.tmdb.org/t/p/original${film.posterPath}",
                        height: 300 + MediaQuery.of(context).size.width * 0.15,
                        width:
                            (300 + MediaQuery.of(context).size.width * 0.15) *
                                0.667,
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(
                        "assets/images/film_vertical_placeholder.svg",
                        height: 300 + MediaQuery.of(context).size.width * 0.15,
                        width:
                            (300 + MediaQuery.of(context).size.width * 0.15) *
                                0.667,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          FutureBuilder<Film>(
            future: TheMovieDbClient().fetchDetailsResults(
              "${film.mediaType}/${film.id}?language=vi&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            builder: (context, snapshot) {
              onLoad(snapshot.connectionState);
              if (snapshot.hasData) {
                final film = snapshot.data as Film;
                AdminClient().historyStore(Member(
                  mediaType: film.mediaType,
                  film: film,
                ));
                // Future.delayed(Duration(seconds: 2), () {
                // print('Delayed code executed');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "${film.name}${film.title}",
                            style: const TextStyle(
                                color: MyFilmAppColors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        if (film.tagline != "")
                          Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              film.tagline,
                              style: const TextStyle(
                                  color: MyFilmAppColors.gray,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "${film.voteAverage}",
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
                            rating: film.voteAverage,
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
                                "${film.runtime} m",
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
                                "Ngôn ngữ",
                                style: TextStyle(
                                  color: MyFilmAppColors.gray,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                film.originalLanguage,
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
                              if (film.mediaType == "tv")
                                Text(
                                  (film.firstAirDate == "")
                                      ? ""
                                      : film.firstAirDate.substring(0, 4),
                                  style: const TextStyle(
                                    color: MyFilmAppColors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0,
                                  ),
                                )
                              else if (film.mediaType == "movie")
                                Text(
                                  (film.releaseDate == "")
                                      ? ""
                                      : film.releaseDate.substring(0, 4),
                                  style: const TextStyle(
                                    color: MyFilmAppColors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: CardOverview(
                        film: film,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: ButtonWatchlist(
                        member: Member(
                          mediaType: film.mediaType,
                          film: film,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Đánh giá phim",
                            style: TextStyle(
                              color: MyFilmAppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          MyStarRating(
                            member: Member(
                              mediaType: film.mediaType,
                              film: film,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyListView(
                      future: TheMovieDbClient().fetchCreditResults(
                        "${film.mediaType}/${film.id}/credits?language=en-US&api_key=7bb0f209157f0bb4788ecb54be635d14",
                      ),
                      listBuilder: (snapshot) => snapshot.data?.listCast,
                      myItemBuilder: (items) {
                        List casts = [];
                        if (items != null) {
                          casts = items;
                        }
                        return ListViewHorizontal(
                          height: 310,
                          title: "Diễn viên",
                          padding: const EdgeInsets.only(left: 10.0),
                          items: casts,
                          myItemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              child: CardCredit(
                                person: casts[index],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyListView(
                      future: TheMovieDbClient().fetchImageResults(
                        "${film.mediaType}/${film.id}/images?language=en&api_key=7bb0f209157f0bb4788ecb54be635d14",
                      ),
                      listBuilder: (snapshot) => snapshot.data?.listBackdrop,
                      myItemBuilder: (items) {
                        List<ImageModel> backdrops = [];
                        if (items != null) {
                          backdrops = items.cast<ImageModel>();
                        }
                        return Column(
                          children: [
                            ListViewHorizontal(
                              title: "Tập ảnh",
                              padding: const EdgeInsets.only(left: 10.0),
                              height: 150,
                              items: backdrops,
                              myItemBuilder: (context, index) {
                                return Container(
                                  width: 150 * backdrops[index].aspectRatio,
                                  margin: const EdgeInsets.only(left: 10.0),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/original${backdrops[index].filePath}",
                                    height: 150,
                                    width: 150 * backdrops[index].aspectRatio,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      },
                    ),
                    if (film.genres.isNotEmpty)
                      ListViewHorizontal(
                        title: "Thể loại",
                        height: 35,
                        padding: const EdgeInsets.only(left: 10.0),
                        items: film.genres,
                        myItemBuilder: (context, index) {
                          return MyOutlinedButton(
                            margin: const EdgeInsets.only(left: 10.0),
                            name: film.genres[index].name,
                            mySearch: MySearch(
                              mediaType: film.mediaType,
                              withGenres: "${film.genres[index].id}",
                            ),
                          );
                        },
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyListView(
                      future: TheMovieDbClient().fetchResults(
                        "${film.mediaType}/${film.id}/keywords?api_key=7bb0f209157f0bb4788ecb54be635d14",
                      ),
                      listBuilder: (snapshot) {
                        List<Film> keywords = [];
                        if (film.mediaType == "movie") {
                          keywords = snapshot.data?.keywords as List<Film>;
                        } else if (film.mediaType == "tv") {
                          keywords = snapshot.data?.items as List<Film>;
                        }
                        return keywords;
                      },
                      myItemBuilder: (items) {
                        List keywords = (items != null) ? items : [];
                        return Column(
                          children: [
                            ListViewHorizontal(
                              height: 35,
                              title: "Từ khóa",
                              padding: const EdgeInsets.only(left: 10.0),
                              items: items,
                              myItemBuilder: (context, index) {
                                return MyOutlinedButton(
                                  margin: const EdgeInsets.only(left: 10.0),
                                  name: keywords[index].name,
                                  mySearch: MySearch(
                                    mediaType: film.mediaType,
                                    withKeywords: "${keywords[index].id}",
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        _futureUser.then((value) {
                          Navigator.pushNamed(
                            context,
                            AddReview.routeName,
                            arguments:
                                Member(mediaType: film.mediaType, film: film),
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
                    MyListView(
                      future: TheMovieDbClient().fetchReviewResults(
                        "${film.mediaType}/${film.id}/reviews?api_key=7bb0f209157f0bb4788ecb54be635d14",
                      ),
                      listBuilder: (snapshot) => snapshot.data!.items,
                      myItemBuilder: (items) {
                        List<Review> reviews = [];
                        if (items != null) {
                          reviews = items.cast<Review>();
                        }
                        return FutureBuilder<ListReview>(
                          future: TheMovieDbClient().fetchUserReviewResults(
                            Member(
                              mediaType: film.mediaType,
                              film: film,
                            ),
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var myUserReviews =
                                  snapshot.data?.items as List<Review>;
                              reviews.addAll(myUserReviews);
                            }
                            if (reviews.isNotEmpty) {
                              return Column(
                                children: [
                                  ListViewHorizontal(
                                    height: 150,
                                    title: "Bình luận phim",
                                    padding: const EdgeInsets.only(left: 10.0),
                                    items: reviews,
                                    myItemBuilder: (context, index) {
                                      return CardReview(
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                        review: reviews[index],
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                            // By default, show a loading spinner.
                          },
                        );
                      },
                    ),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: const Text(
                                "Chi tiết",
                                style: TextStyle(
                                    color: MyFilmAppColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            if (film.budget != 0)
                              ItemDetail(
                                name: "Ngân sách",
                                content: "${film.budget}",
                                margin: const EdgeInsets.only(left: 10.0),
                              ),
                            if (film.revenue != 0)
                              ItemDetail(
                                name: "Doanh thu",
                                content: "${film.revenue}",
                                margin: const EdgeInsets.only(left: 10.0),
                              ),
                            if (film.homepage != "")
                              ItemDetail(
                                name: "Trang chủ chính",
                                content: film.homepage,
                                margin: const EdgeInsets.only(left: 10.0),
                              ),
                            if (film.belongsToCollection.name != "")
                              ItemDetail(
                                name: "Trọn bộ phần phim",
                                content: film.belongsToCollection.name,
                                margin: const EdgeInsets.only(left: 10.0),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    MovieCollections.routeName,
                                    arguments: film,
                                  );
                                },
                              ),
                            if (film.numberOfSeasons != 0)
                              ItemDetail(
                                name: "Các mùa phim",
                                content: "${film.numberOfSeasons} mùa",
                                margin: const EdgeInsets.only(left: 10.0),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    TvSeason.routeName,
                                    arguments: film,
                                  );
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyListView(
                      future: TheMovieDbClient().fetchResults(
                        "${film.mediaType}/${film.id}/recommendations?language=en&api_key=7bb0f209157f0bb4788ecb54be635d14",
                      ),
                      listBuilder: (snapshot) => snapshot.data!.items,
                      myItemBuilder: (items) {
                        return ListViewHorizontal(
                          title: "Đề xuất",
                          padding: const EdgeInsets.only(left: 10.0),
                          items: items,
                          myItemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: CardBackdrop(
                                film: items?[index],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (film.networks.isNotEmpty)
                      ListViewHorizontal(
                        title: "Kênh truyền hình",
                        between: 5,
                        padding: const EdgeInsets.only(left: 10.0),
                        height: 40,
                        items: film.networks,
                        myItemBuilder: (context, index) {
                          return Container(
                            color: MyFilmAppColors.white,
                            margin: const EdgeInsets.only(left: 10.0),
                            padding: const EdgeInsets.all(2),
                            child: (film.networks[index].logoPath != "")
                                ? Image.network(
                                    "https://image.tmdb.org/t/p/original${film.networks[index].logoPath}",
                                  )
                                : const SizedBox(
                                    height: 40,
                                    width: 40,
                                  ),
                          );
                        },
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (film.productionCountries.isNotEmpty)
                      ListViewHorizontal(
                        title: "Các quốc gia sản xuất",
                        padding: const EdgeInsets.only(left: 10.0),
                        height: 48,
                        between: 5,
                        items: film.productionCountries,
                        myItemBuilder: (context, index) {
                          return Container(
                            color: MyFilmAppColors.white,
                            margin: const EdgeInsets.only(left: 10.0),
                            child:
                                (film.productionCountries[index].iso_3166_1 !=
                                        "")
                                    ? Image.network(
                                        "https://flagsapi.com/${film.productionCountries[index].iso_3166_1}/flat/48.png",
                                      )
                                    : const SizedBox(
                                        height: 40,
                                        width: 40,
                                      ),
                          );
                        },
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (film.productionCompanies.isNotEmpty)
                      ListViewHorizontal(
                        title: "Công ty sản xuất",
                        padding: const EdgeInsets.only(left: 10.0),
                        height: 48,
                        between: 5,
                        items: film.productionCompanies,
                        myItemBuilder: (context, index) {
                          return Container(
                            color: MyFilmAppColors.white,
                            margin: const EdgeInsets.only(left: 10.0),
                            child:
                                (film.productionCompanies[index].logoPath != "")
                                    ? Image.network(
                                        "https://image.tmdb.org/t/p/original${film.productionCompanies[index].logoPath}",
                                      )
                                    : const SizedBox(
                                        height: 40,
                                        width: 40,
                                      ),
                          );
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
                                left: 10.0,
                                right: 10.0,
                                top: 10.0,
                                bottom: 10.0,
                              ),
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
                            "${film.mediaType}/${film.id}/external_ids?api_key=7bb0f209157f0bb4788ecb54be635d14",
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final externalIdFilm =
                                  snapshot.data as ExternalId;
                              return Column(
                                children: [
                                  if (externalIdFilm.imdbId != "")
                                    ItemExternalSource(
                                      margin: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 0,
                                        top: 0,
                                      ),
                                      name: "Imdb",
                                      externalId: externalIdFilm.imdbId,
                                    ),
                                  if (externalIdFilm.facebookId != "")
                                    ItemExternalSource(
                                      name: "Facebook",
                                      margin: const EdgeInsets.only(
                                        left: 10.0,
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
                                        left: 10.0,
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
                                        left: 10.0,
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
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 0,
                                        top: 0,
                                      ),
                                      externalId: externalIdFilm.wikidataId,
                                    ),
                                ],
                              );
                              // } else if (snapshot.hasError) {
                              //   return Text(
                              //     '${snapshot.error}',
                              //     style: const TextStyle(
                              //         color: MyFilmAppColors.white),
                              //   );
                            }

                            // By default, show a loading spinner.
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                );
                // });
                // } else if (snapshot.hasError) {
                //   return Text(
                //     '${snapshot.error}',
                //     style: const TextStyle(color: MyFilmAppColors.white),
                //   );
              }

              // By default, show a loading spinner.
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
