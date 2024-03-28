import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/auth/profile.dart';
import 'package:myfilmapp/screens/home/home.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({
    super.key,
  });
  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
      }

      debugPrint("$index");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
