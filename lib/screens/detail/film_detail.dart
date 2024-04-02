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
import 'package:myfilmapp/model/user.dart';
import 'package:myfilmapp/screens/form/add_review.dart';
import 'package:myfilmapp/screens/season/movie_collections.dart';
import 'package:myfilmapp/screens/season/tv_season.dart';
import 'package:myfilmapp/widgets/button_watchlist.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';
import 'package:myfilmapp/widgets/card_credit.dart';
import 'package:myfilmapp/widgets/item_detail.dart';
import 'package:myfilmapp/widgets/item_external_source.dart';
import 'package:myfilmapp/widgets/navbar.dart';
import 'package:myfilmapp/widgets/star_rating_modal.dart';
import 'package:quickalert/quickalert.dart';
import 'package:star_rating/star_rating.dart';

class FilmDetail extends StatefulWidget {
  static const routeName = '/filmDetail';
  const FilmDetail({Key? key}) : super(key: key);

  @override
  State<FilmDetail> createState() => _FilmDetailState();
}

class _FilmDetailState extends State<FilmDetail> {
  late Future<User> _futureUser;
  void initState() {
    // TODO: implement initState
    super.initState();
    // MyFilmAppDatabase().historyStore();
    _futureUser = AdminClient().loginUser();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Film;

    return Scaffold(
      backgroundColor: MyFilmAppColors.body,
      appBar: Navbar(
        backButton: true,
        title: "${args.name}${args.title}",
      ),
      body: FutureBuilder<Film>(
        future: TheMovieDbClient().fetchDetailsResults(
          "${args.mediaType}/${args.id}?language=en-US&api_key=7bb0f209157f0bb4788ecb54be635d14",
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final film = snapshot.data as Film;
            print(
                "Công ty ${args.id}: ${film.productionCompanies[0].logoPath == ""}");
            // AdminClient().historyStore(Member(
            //   mediaType: film.mediaType,
            //   film: film,
            // ));
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
                                "https://image.tmdb.org/t/p/original${film.posterPath}",
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
                              film.overview,
                              style: const TextStyle(
                                  color: MyFilmAppColors.longText),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ButtonWatchlist(
                        member: Member(
                          mediaType: film.mediaType,
                          film: film,
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
                                "${film.mediaType}/${film.id}/credits?language=en-US&api_key=7bb0f209157f0bb4788ecb54be635d14"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final casts =
                                    snapshot.data?.listCast as List<Person>;
                                return SizedBox(
                                  height: 310,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: casts.length,
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
                                  bottom: 10.0,
                                ),
                                child: const Text(
                                  "Tập ảnh",
                                  style: TextStyle(
                                      color: MyFilmAppColors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          FutureBuilder<ListImage>(
                            future: TheMovieDbClient().fetchImageResults(
                              "${film.mediaType}/${film.id}/images?language=en&api_key=7bb0f209157f0bb4788ecb54be635d14",
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final backdrops = snapshot.data?.listBackdrop
                                    as List<ImageModel>;
                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: backdrops.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width:
                                            150 * backdrops[index].aspectRatio,
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Image.network(
                                          "https://image.tmdb.org/t/p/original${backdrops[index].filePath}",
                                          height: 150,
                                          width: 150 *
                                              backdrops[index].aspectRatio,
                                          fit: BoxFit.cover,
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
                                  "Thể loại",
                                  style: TextStyle(
                                    color: MyFilmAppColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            height: 35,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: film.genres.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 10.0),
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      film.genres[index].name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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
                                  "Từ khóa",
                                  style: TextStyle(
                                    color: MyFilmAppColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FutureBuilder<ListFilm>(
                            future: TheMovieDbClient().fetchResults(
                              "${film.mediaType}/${film.id}/keywords?api_key=7bb0f209157f0bb4788ecb54be635d14",
                            ),
                            builder: (context, snapshot) {
                              print(
                                  "${film.mediaType}/${film.id}/keywords?api_key=7bb0f209157f0bb4788ecb54be635d14");
                              if (snapshot.hasData) {
                                var keywords;
                                if (film.mediaType == "movie") {
                                  keywords =
                                      snapshot.data?.keywords as List<Film>;
                                } else if (film.mediaType == "tv") {
                                  keywords = snapshot.data?.items as List<Film>;
                                }
                                return Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  height: 35,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: keywords.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            keywords[index].name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
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
                        height: 20,
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
                      FutureBuilder<ListReview>(
                        future: TheMovieDbClient().fetchReviewResults(
                          "${film.mediaType}/${film.id}/reviews?api_key=7bb0f209157f0bb4788ecb54be635d14",
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var reviews = snapshot.data?.items as List<Review>;
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
                                        alignment:
                                            AlignmentDirectional.centerStart,
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
                                                              color:
                                                                  MyFilmAppColors
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
                                // By default, show a loading spinner.
                              },
                            );
                            // } else if (snapshot.hasError) {
                            //   return Text(
                            //     '${snapshot.error}',
                            //     style:
                            //         const TextStyle(color: MyFilmAppColors.white),
                            //   );
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
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
                                ),
                              if (film.revenue != 0)
                                ItemDetail(
                                  name: "Doanh thu",
                                  content: "${film.revenue}",
                                ),
                              if (film.homepage != "")
                                ItemDetail(
                                  name: "Trang chủ chính",
                                  content: film.homepage,
                                ),
                              if (film.belongsToCollection.name != "")
                                ItemDetail(
                                  name: "Trọn bộ phần phim",
                                  content: film.belongsToCollection.name,
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
                      FutureBuilder<ListFilm>(
                        future: TheMovieDbClient().fetchResults(
                          "${film.mediaType}/${film.id}/recommendations?language=en&api_key=7bb0f209157f0bb4788ecb54be635d14",
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Film> films = snapshot.data!.items;
                            if (films.isNotEmpty) {
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
                                            bottom: 10.0),
                                        child: const Text(
                                          "Đề xuất",
                                          style: TextStyle(
                                              color: MyFilmAppColors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 250,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: films.length,
                                      itemBuilder: (context, index) {
                                        Film film = films[index];
                                        return CardBackdrop(
                                          film: film,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox(
                                height: 15,
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Text(
                              '${snapshot.error}',
                              style:
                                  const TextStyle(color: MyFilmAppColors.white),
                            );
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                      if (film.networks.isNotEmpty)
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
                                    "Kênh truyền hình",
                                    style: TextStyle(
                                        color: MyFilmAppColors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 40,
                              alignment: AlignmentDirectional.centerStart,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: film.networks.length,
                                itemBuilder: (context, index) {
                                  if (film.networks[index].logoPath != "") {
                                    return Container(
                                      color: MyFilmAppColors.white,
                                      margin: const EdgeInsets.only(left: 10.0),
                                      padding: const EdgeInsets.all(2),
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/original${film.networks[index].logoPath}",
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      color: MyFilmAppColors.white,
                                      margin: const EdgeInsets.only(left: 15.0),
                                      padding: const EdgeInsets.all(2),
                                      height: 40,
                                      width: 40,
                                      // child: Image.network(
                                      //   "https://image.tmdb.org/t/p/original${film.productionCompanies[index].logoPath}",
                                      // ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      if (film.productionCountries.isNotEmpty)
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
                                    "Các quốc gia sản xuât",
                                    style: TextStyle(
                                        color: MyFilmAppColors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 48,
                              alignment: AlignmentDirectional.centerStart,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: film.productionCountries.length,
                                itemBuilder: (context, index) {
                                  if (film.productionCountries[index]
                                          .iso_3166_1 !=
                                      "") {
                                    return Container(
                                      color: MyFilmAppColors.white,
                                      margin: const EdgeInsets.only(left: 10.0),
                                      padding: const EdgeInsets.all(2),
                                      child: Image.network(
                                        "https://flagsapi.com/${film.productionCountries[index].iso_3166_1}/flat/48.png",
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      color: MyFilmAppColors.white,
                                      margin: const EdgeInsets.only(left: 15.0),
                                      padding: const EdgeInsets.all(2),
                                      height: 40,
                                      width: 40,
                                      // child: Image.network(
                                      //   "https://image.tmdb.org/t/p/original${film.productionCompanies[index].logoPath}",
                                      // ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      if (film.productionCompanies.isNotEmpty)
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
                                    "Công ty sản xuât",
                                    style: TextStyle(
                                      color: MyFilmAppColors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 40,
                              alignment: AlignmentDirectional.centerStart,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: film.productionCompanies.length,
                                itemBuilder: (context, index) {
                                  if (film.productionCompanies[index]
                                          .logoPath !=
                                      "") {
                                    return Container(
                                      color: MyFilmAppColors.white,
                                      margin: const EdgeInsets.only(left: 15.0),
                                      padding: const EdgeInsets.all(2),
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/original${film.productionCompanies[index].logoPath}",
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      color: MyFilmAppColors.white,
                                      margin: const EdgeInsets.only(left: 15.0),
                                      padding: const EdgeInsets.all(2),
                                      height: 40,
                                      width: 40,
                                      // child: Image.network(
                                      //   "https://image.tmdb.org/t/p/original${film.productionCompanies[index].logoPath}",
                                      // ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
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
                                "${film.mediaType}/${film.id}/external_ids?api_key=7bb0f209157f0bb4788ecb54be635d14"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final externalIdFilm =
                                    snapshot.data as ExternalId;
                                return Column(
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
                                        externalId: externalIdFilm.instagramId,
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
                                );
                                // } else if (snapshot.hasError) {
                                //   return Text(
                                //     '${snapshot.error}',
                                //     style: const TextStyle(
                                //         color: MyFilmAppColors.white),
                                //   );
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
                    ],
                  ),
                ),
              ),
            );
            // } else if (snapshot.hasError) {
            //   return Text(
            //     '${snapshot.error}',
            //     style: const TextStyle(color: MyFilmAppColors.white),
            //   );
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
