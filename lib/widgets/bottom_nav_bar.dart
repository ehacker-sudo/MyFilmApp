import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/auth/profile.dart';
import 'package:myfilmapp/screens/home/home.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 65,
      color: MyFilmAppColors.header,
      notchMargin: 10,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/home_active.svg',
                      height: 28,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Trang chủ',
                      style:
                          TextStyle(color: MyFilmAppColors.white, fontSize: 11),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 32,
                      width: 32,
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
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      'Hồ sơ',
                      style: TextStyle(
                          color: MyFilmAppColors.itemActive, fontSize: 11),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
