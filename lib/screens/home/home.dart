import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/auth/profile.dart';
import 'package:myfilmapp/widgets/card_banner.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';
import 'package:myfilmapp/widgets/card_poster.dart';
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
              SizedBox(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const CardBanner(
                      backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                      title: "True Detective",
                    );
                  },
                ),
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
              SizedBox(
                height: 180 + 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const CardBackdrop(
                      backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                      title: "True Detective",
                    );
                  },
                ),
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
              SizedBox(
                height: 180 + 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const CardBackdrop(
                      backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                      title: "True Detective",
                    );
                  },
                ),
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
              SizedBox(
                height: 180 + 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const CardBackdrop(
                      backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                      title: "True Detective",
                    );
                  },
                ),
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
              SizedBox(
                height: 180 + 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const CardBackdrop(
                      backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                      title: "True Detective",
                    );
                  },
                ),
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
              SizedBox(
                height: 180 + 50,
                child: Scrollbar(
                  thickness: 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const CardBackdrop(
                        backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                        title: "True Detective",
                      );
                    },
                  ),
                ),
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
              SizedBox(
                height: 180 + 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const CardBackdrop(
                      backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                      title: "True Detective",
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: const Navbar(
        currentPage: "Home",
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
          // BottomNavigationBarItem(
          //   icon: Container(
          //     padding: const EdgeInsets.only(bottom: 3, top: 4),
          //     child: SvgPicture.asset(
          //       'assets/images/movie_main.svg',
          //       height: 23,
          //     ),
          //   ),
          //   activeIcon: Container(
          //     padding: const EdgeInsets.only(bottom: 3, top: 4),
          //     child: SvgPicture.asset(
          //       'assets/images/movie_active.svg',
          //       height: 23,
          //     ),
          //   ),
          //   label: 'Phim ảnh',
          // ),
          // BottomNavigationBarItem(
          //   icon: Container(
          //     padding: const EdgeInsets.only(bottom: 3, top: 4),
          //     child: SvgPicture.asset(
          //       'assets/images/tv_main.svg',
          //       height: 23,
          //     ),
          //   ),
          //   activeIcon: Container(
          //     padding: const EdgeInsets.only(bottom: 3, top: 4),
          //     child: SvgPicture.asset(
          //       'assets/images/tv_active.svg',
          //       height: 23,
          //     ),
          //   ),
          //   label: 'Phim truyền hình',
          // ),
          BottomNavigationBarItem(
            icon: Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.only(
                bottom: 2,
                top: 2,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
}
