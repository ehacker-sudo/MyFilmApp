import 'package:flutter/material.dart';
import 'package:myfilmapp/api/user_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/model/auth.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/screens/auth/login.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const Navbar(),
      body: Container(
        decoration: const BoxDecoration(color: MyFilmAppColors.body),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/user.svg',
                    height: 20,
                  ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.white,
                  //   child: Text('AH'),
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Đăng nhập",
                    style:
                        TextStyle(color: MyFilmAppColors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.only(top: 5, bottom: 5)),
                  backgroundColor: MaterialStateProperty.all(
                    MyFilmAppColors.submain,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      // Change your radius here
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                child: const Text(
                  "Đăng nhập / Đăng ký",
                  style: TextStyle(color: MyFilmAppColors.white, fontSize: 15),
                ),
              ),
            ),
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
                    "Lịch sử xem",
                    style: TextStyle(
                      color: MyFilmAppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                FutureBuilder<ListMember>(
                  future: AdminClient().historyUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Film> films = snapshot.data!.results;
                      return SizedBox(
                        height: 180 + 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: films.length,
                          itemBuilder: (context, index) {
                            return CardBackdrop(
                              // film: snapshot.data!.items[index],
                              film: films[index],
                            );
                          },
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
              ],
            ),
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
                    "Danh sách xem",
                    style: TextStyle(
                      color: MyFilmAppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                FutureBuilder<ListMember>(
                  future: AdminClient().watchlistUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Film> films = snapshot.data!.results;
                      return SizedBox(
                        height: 180 + 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: films.length,
                          itemBuilder: (context, index) {
                            return CardBackdrop(
                              // film: snapshot.data!.items[index],
                              film: films[index],
                            );
                          },
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
