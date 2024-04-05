import 'package:flutter/material.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/widgets/bottom_navigation_bar.dart';
import 'package:myfilmapp/widgets/card_banner.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';
import 'package:myfilmapp/widgets/drawer.dart';
import 'package:myfilmapp/widgets/list_view_horizontal.dart';
import 'package:myfilmapp/widgets/navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination(
    'Trang chủ',
    SvgPicture.asset(
      'assets/images/home_main.svg',
      height: 25,
    ),
    SvgPicture.asset(
      'assets/images/home_black_active.svg',
      height: 25,
    ),
  ),
  ExampleDestination(
    'Trang chủ',
    SvgPicture.asset(
      'assets/images/tv_main.svg',
      height: 25,
    ),
    SvgPicture.asset(
      'assets/images/tv_active.svg',
      height: 25,
    ),
  ),
  ExampleDestination(
    'Trang chủ',
    SvgPicture.asset(
      'assets/images/movie_main.svg',
      height: 25,
    ),
    SvgPicture.asset(
      'assets/images/movie_active.svg',
      height: 25,
    ),
  ),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool showNavigationDrawer;

  @override
  void initState() {
    super.initState();
  }

  Widget home() {
    return Container(
      decoration: const BoxDecoration(color: MyFilmAppColors.body),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<ListFilm>(
            future: TheMovieDbClient().fetchResults(
              "trending/all/day?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15, bottom: 10),
                      child: const Text(
                        "Xu hướng",
                        style: TextStyle(
                          color: MyFilmAppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.items.length,
                        itemBuilder: (context, index) {
                          return CardBanner(
                            film: snapshot.data!.items[index],
                          );
                        },
                      ),
                    )
                  ],
                );
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
          const SizedBox(
            height: 30,
          ),
          movie(),
          const SizedBox(
            height: 30,
          ),
          tv(),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget movie() {
    return Container(
      decoration: const BoxDecoration(color: MyFilmAppColors.body),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListViewHorizontal(
            future: TheMovieDbClient().fetchResults(
              "movie/top_rated?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            title: "Top phim ảnh",
            padding: const EdgeInsets.only(left: 10.0),
          ),
          const SizedBox(
            height: 30,
          ),
          ListViewHorizontal(
            future: TheMovieDbClient().fetchResults(
              "movie/upcoming?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            title: "Phim ảnh sắp ra mắt",
            padding: const EdgeInsets.only(left: 10.0),
          ),
          const SizedBox(
            height: 30,
          ),
          ListViewHorizontal(
            future: TheMovieDbClient().fetchResults(
              "movie/now_playing?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            title: "Phim ảnh hiện công chiếu",
            padding: const EdgeInsets.only(left: 10.0),
          ),
        ],
      ),
    );
  }

  Widget tv() {
    return Container(
      decoration: const BoxDecoration(color: MyFilmAppColors.body),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListViewHorizontal(
            future: TheMovieDbClient().fetchResults(
              "tv/top_rated?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            title: "Top phim truyền hình",
            padding: const EdgeInsets.only(left: 10.0),
          ),
          const SizedBox(
            height: 30,
          ),
          ListViewHorizontal(
            future: TheMovieDbClient().fetchResults(
              "tv/on_the_air?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            title: "Vẫn còn lên sóng",
            padding: const EdgeInsets.only(left: 10.0),
          ),
          const SizedBox(
            height: 30,
          ),
          ListViewHorizontal(
            future: TheMovieDbClient().fetchResults(
              "tv/airing_today?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            title: "Đang được lên sóng",
            padding: const EdgeInsets.only(left: 10.0),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(),
      body: home(),
      drawer: const MyDrawer(currentPage: "Home"),
    );
  }

  Widget buildBottomBarScaffold() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        mobileMode: true,
      ),
      body: home(),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 500;
  }

  @override
  Widget build(BuildContext context) {
    return showNavigationDrawer
        ? buildDrawerScaffold(context)
        : buildBottomBarScaffold();
  }
}
