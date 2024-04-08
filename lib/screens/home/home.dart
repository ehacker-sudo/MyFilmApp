import 'package:flutter/material.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/widgets/bottom_navigation_bar.dart';
import 'package:myfilmapp/widgets/card_banner.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';
import 'package:myfilmapp/widgets/drawer.dart';
import 'package:myfilmapp/widgets/list_view.dart';
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
          MyListView(
            future: TheMovieDbClient().fetchResults(
              "trending/all/day?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            listBuilder: (snapshot) => snapshot.data!.items,
            myItemBuilder: (items) {
              List films = [];
              if (items != null) {
                films = items;
              }
              return ListViewHorizontal(
                height: 250,
                title: "Xu hướng",
                padding: const EdgeInsets.only(left: 10.0),
                items: items,
                myItemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: CardBanner(
                      film: films[index],
                    ),
                  );
                },
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
          MyListView(
            future: TheMovieDbClient().fetchResults(
              "movie/top_rated?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            listBuilder: (snapshot) => snapshot.data!.items,
            myItemBuilder: (items) {
              return ListViewHorizontal(
                title: "Top phim ảnh",
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
            height: 30,
          ),
          MyListView(
            future: TheMovieDbClient().fetchResults(
              "movie/upcoming?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            listBuilder: (snapshot) => snapshot.data!.items,
            myItemBuilder: (items) {
              return ListViewHorizontal(
                title: "Phim ảnh sắp ra mắt",
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
            height: 30,
          ),
          MyListView(
            future: TheMovieDbClient().fetchResults(
              "movie/now_playing?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            listBuilder: (snapshot) => snapshot.data!.items,
            myItemBuilder: (items) {
              return ListViewHorizontal(
                title: "Phim ảnh hiện công chiếu",
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
          MyListView(
            future: TheMovieDbClient().fetchResults(
              "tv/top_rated?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            listBuilder: (snapshot) => snapshot.data!.items,
            myItemBuilder: (items) {
              return ListViewHorizontal(
                title: "Top phim truyền hình",
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
            height: 30,
          ),
          MyListView(
            future: TheMovieDbClient().fetchResults(
              "tv/on_the_air?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            listBuilder: (snapshot) => snapshot.data!.items,
            myItemBuilder: (items) {
              return ListViewHorizontal(
                title: "Vẫn còn lên sóng",
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
            height: 30,
          ),
          MyListView(
            future: TheMovieDbClient().fetchResults(
              "tv/airing_today?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14",
            ),
            listBuilder: (snapshot) => snapshot.data!.items,
            myItemBuilder: (items) {
              return ListViewHorizontal(
                title: "Đang được lên sóng",
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
