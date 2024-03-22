import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/auth/profile.dart';
import 'package:myfilmapp/screens/home/home.dart';
import 'package:myfilmapp/widgets/drawer_tile.dart';
import 'package:myfilmapp/widgets/logo_app.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  final String currentPage;

  const MyDrawer({super.key, String? currentPage})
      : currentPage = currentPage ?? "";

  _launchURL() async {
    const url = 'https://creative-tim.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: MyFilmAppColors.header,
      child: Column(children: [
        SizedBox(
          height: 110,
          child: SafeArea(
            bottom: false,
            child: Container(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  LogoApp(
                    width: 47,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView(
            children: [
              DrawerTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  title: "Trang chủ",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
                    );
                  },
                  title: "Tài khoản",
                  isSelected: currentPage == "Components" ? true : false),
            ],
          ),
        ),
      ]),
    ));
  }
}
