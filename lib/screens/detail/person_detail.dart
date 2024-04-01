import 'package:flutter/material.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/episode.dart';
import 'package:myfilmapp/model/external_id.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/image.dart';
import 'package:myfilmapp/model/person.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';
import 'package:myfilmapp/widgets/card_credit.dart';
import 'package:myfilmapp/widgets/item_detail.dart';
import 'package:myfilmapp/widgets/item_external_source.dart';
import 'package:myfilmapp/widgets/navbar.dart';
import 'package:myfilmapp/database/database.dart';
import 'package:myfilmapp/widgets/star_rating_modal.dart';
import 'package:star_rating/star_rating.dart';

class PersonDetail extends StatefulWidget {
  static const routeName = '/personDetail';
  const PersonDetail({Key? key}) : super(key: key);

  @override
  State<PersonDetail> createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // MyFilmAppDatabase().historyStore();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Person;
    print("${args.id} ${args.name}");
    return Scaffold(
      backgroundColor: MyFilmAppColors.body,
      appBar: Navbar(
        backButton: true,
        title: args.name,
      ),
      body: FutureBuilder<Person>(
        future: TheMovieDbClient().fetchPersonResults(
          "person/${args.id}?api_key=7bb0f209157f0bb4788ecb54be635d14",
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final person = snapshot.data as Person;
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
                                "https://image.tmdb.org/t/p/original${person.profilePath}",
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
                              person.name,
                              style: const TextStyle(
                                  color: MyFilmAppColors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
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
                              "Tiểu sử",
                              style: TextStyle(
                                  color: MyFilmAppColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              person.biography,
                              style: const TextStyle(
                                  color: MyFilmAppColors.longText),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder<ListImage>(
                        future: TheMovieDbClient().fetchImageResults(
                          "person/${person.id}/images?api_key=7bb0f209157f0bb4788ecb54be635d14",
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final profiles =
                                snapshot.data?.listProfiles as List<ImageModel>;
                            print(profiles);
                            if (profiles.isNotEmpty) {
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
                                      itemCount: profiles.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width:
                                              150 * profiles[index].aspectRatio,
                                          margin:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Image.network(
                                            "https://image.tmdb.org/t/p/original${profiles[index].filePath}",
                                            height: 150,
                                            width: 150 *
                                                profiles[index].aspectRatio,
                                            fit: BoxFit.cover,
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
                              if (person.birthday != "")
                                ItemDetail(
                                  name: "Ngày sinh",
                                  content: person.birthday,
                                ),
                              if (person.deathday != "")
                                ItemDetail(
                                  name: "Ngày mất",
                                  content: person.deathday,
                                ),
                              if (person.placeOfBirth != "")
                                ItemDetail(
                                  name: "Nơi sinh",
                                  content: person.placeOfBirth,
                                ),
                              if (person.homepage != "")
                                ItemDetail(
                                  name: "Trang chủ chính",
                                  content: person.homepage,
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder<ListFilm>(
                        future: TheMovieDbClient().fetchResults(
                            "person/${person.id}/movie_credits?api_key=7bb0f209157f0bb4788ecb54be635d14"),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Film> casts = snapshot.data!.cast;
                            if (casts.isNotEmpty) {
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
                                          "Phim ảnh nổi bật",
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
                                      itemCount: snapshot.data!.cast.length,
                                      itemBuilder: (context, index) {
                                        return CardBackdrop(
                                          film: snapshot.data!.cast[index],
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
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder<ListFilm>(
                        future: TheMovieDbClient().fetchResults(
                            "person/${person.id}/tv_credits?api_key=7bb0f209157f0bb4788ecb54be635d14"),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Film> casts = snapshot.data!.cast;
                            if (casts.isNotEmpty) {
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
                                          "Phim truyền hình nổi bật",
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
                                      itemCount: snapshot.data!.cast.length,
                                      itemBuilder: (context, index) {
                                        return CardBackdrop(
                                          film: snapshot.data!.cast[index],
                                        );
                                      },
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
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
                          SizedBox(
                            height: 50.0,
                            child: Column(
                              children: [
                                if (person.imdbId != "")
                                  ItemExternalSource(
                                    name: "Imdb",
                                    mediaType: "person",
                                    externalId: person.imdbId,
                                  ),
                              ],
                            ),
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
