import 'package:flutter/material.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/screens/auth/profile.dart';
import 'package:myfilmapp/widgets/card_banner.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';
import 'package:myfilmapp/widgets/card_poster.dart';
import 'package:myfilmapp/widgets/drawer.dart';
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
  late TheMovieDbClient api;
  int screenIndex = 0;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
      }
      debugPrint("$index");
    });
  }

  @override
  void initState() {
    super.initState();
    api = TheMovieDbClient();
  }

  Widget home() {
    return Container(
      decoration: const BoxDecoration(color: MyFilmAppColors.body),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Column(
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
              FutureBuilder<ListFilm>(
                future: api.fetchResults(
                    "trending/all/day?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
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
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: MyFilmAppColors.white),
                    );
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ],
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: const Text(
                  "Top phim ảnh",
                  style: TextStyle(
                    color: MyFilmAppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              FutureBuilder<ListFilm>(
                future: api.fetchResults(
                    "movie/top_rated?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 180 + 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.items.length,
                        itemBuilder: (context, index) {
                          return CardBackdrop(
                            film: snapshot.data!.items[index],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: MyFilmAppColors.white),
                    );
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: const Text(
                  "Phim ảnh sắp ra mắt",
                  style: TextStyle(
                    color: MyFilmAppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              FutureBuilder<ListFilm>(
                future: api.fetchResults(
                    "movie/upcoming?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 180 + 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.items.length,
                        itemBuilder: (context, index) {
                          return CardBackdrop(
                            film: snapshot.data!.items[index],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: MyFilmAppColors.white),
                    );
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: const Text(
                  "Phim ảnh hiện công chiếu",
                  style: TextStyle(
                    color: MyFilmAppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              FutureBuilder<ListFilm>(
                future: api.fetchResults(
                    "movie/now_playing?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 180 + 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.items.length,
                        itemBuilder: (context, index) {
                          return CardBackdrop(
                            film: snapshot.data!.items[index],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: MyFilmAppColors.white),
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
    );
  }

  Widget tv() {
    return Container(
      decoration: const BoxDecoration(color: MyFilmAppColors.body),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: const Text(
                  "Top phim truyền hình",
                  style: TextStyle(
                    color: MyFilmAppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              FutureBuilder<ListFilm>(
                future: api.fetchResults(
                    "tv/top_rated?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 180 + 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.items.length,
                        itemBuilder: (context, index) {
                          return CardBackdrop(
                            film: snapshot.data!.items[index],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: MyFilmAppColors.white),
                    );
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: const Text(
                  "Vẫn còn lên sóng",
                  style: TextStyle(
                    color: MyFilmAppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              FutureBuilder<ListFilm>(
                future: api.fetchResults(
                    "tv/on_the_air?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 180 + 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.items.length,
                        itemBuilder: (context, index) {
                          return CardBackdrop(
                            film: snapshot.data!.items[index],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: MyFilmAppColors.white),
                    );
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: const Text(
                  "Đang được lên sóng",
                  style: TextStyle(
                    color: MyFilmAppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              FutureBuilder<ListFilm>(
                future: api.fetchResults(
                    "tv/airing_today?language=en-US&page=1&api_key=7bb0f209157f0bb4788ecb54be635d14"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 180 + 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.items.length,
                        itemBuilder: (context, index) {
                          return CardBackdrop(
                            film: snapshot.data!.items[index],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: TextStyle(color: MyFilmAppColors.white),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedLabelStyle:
            const TextStyle(color: MyFilmAppColors.white, fontSize: 11),
        selectedItemColor: MyFilmAppColors.white,
        unselectedItemColor: MyFilmAppColors.itemActive,
        unselectedLabelStyle:
            const TextStyle(color: MyFilmAppColors.itemActive, fontSize: 11),
        backgroundColor: MyFilmAppColors.header,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(bottom: 3, top: 4),
              child: SvgPicture.asset(
                'assets/images/home_main.svg',
                height: 23,
              ),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.only(bottom: 3, top: 4),
              child: SvgPicture.asset(
                'assets/images/home_active.svg',
                height: 23,
              ),
            ),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.only(
                bottom: 2,
                top: 2,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://www.gravatar.com/avatar/ec9c0f2cf7bc38cbc05b23b87c27fcc9?d=monsterid"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            label: 'Tiểu sử',
          ),
        ],
      ),
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
