import 'package:flutter/material.dart';
import 'package:myfilmapp/api/user_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/model/auth.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/user.dart';
import 'package:myfilmapp/screens/auth/login.dart';
import 'package:myfilmapp/screens/detail/episode_detail.dart';
import 'package:myfilmapp/screens/search/advance_search/advance_search_view.dart';
import 'package:myfilmapp/widgets/bottom_navigation_bar.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';
import 'package:myfilmapp/widgets/dropdown_horizontal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<User> _futureUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _futureUser = AdminClient().loginUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const Navbar(),
      body: Container(
        decoration: const BoxDecoration(color: MyFilmAppColors.body),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 20.0),
              child: FutureBuilder<User>(
                future: _futureUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData || snapshot.hasError) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/user.svg',
                              height: 24,
                            ),
                            // CircleAvatar(
                            //   backgroundColor: Colors.white,
                            //   child: Text('AH'),
                            // ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              (snapshot.hasData)
                                  ? snapshot.data!.name
                                  : (snapshot.hasError)
                                      ? "Đăng nhập"
                                      : "Đăng nhập",
                              style: const TextStyle(
                                  color: MyFilmAppColors.white, fontSize: 15),
                            )
                          ],
                        ),
                        if (snapshot.hasData) const DropdownHorizontal()
                      ],
                    );
                  }

                  // By default, show a loading spinner.
                  return const Column(
                    children: [CircularProgressIndicator()],
                  );
                },
              ),
            ),
            FutureBuilder<User>(
              future: _futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const SizedBox();
                } else if (snapshot.hasError) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
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
                        style: TextStyle(
                            color: MyFilmAppColors.white, fontSize: 15),
                      ),
                    ),
                  );
                }

                // By default, show a loading spinner.
                return Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: const Column(
                    children: [CircularProgressIndicator()],
                  ),
                );
              },
            ),
            FutureBuilder<User>(
              future: _futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        color: MyFilmAppColors.header,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 20.0),
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
                                  List<Member> members = snapshot.data!.results;
                                  return SizedBox(
                                    height: 180 + 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: members.length,
                                      itemBuilder: (context, index) {
                                        if (members[index].mediaType ==
                                            "episode") {
                                          return Container(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: CardBackdrop(
                                              // film: snapshot.data!.items[index],
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  EpisodeDetail.routeName,
                                                  arguments:
                                                      members[index].episode,
                                                );
                                              },
                                              film: Film(
                                                name:
                                                    members[index].episode.name,
                                                mediaType: "episode",
                                                firstAirDate: members[index]
                                                    .episode
                                                    .airDate,
                                                backdropPath: members[index]
                                                    .episode
                                                    .stillPath,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: CardBackdrop(
                                              // film: snapshot.data!.items[index],
                                              film: members[index].film,
                                            ),
                                          );
                                        }
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        color: MyFilmAppColors.header,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 20.0),
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
                                  List<Member> members = snapshot.data!.results;
                                  return SizedBox(
                                    height: 180 + 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: members.length,
                                      itemBuilder: (context, index) {
                                        if (members[index].mediaType ==
                                            "episode") {
                                          return Container(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: CardBackdrop(
                                              // film: snapshot.data!.items[index],
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  EpisodeDetail.routeName,
                                                  arguments:
                                                      members[index].episode,
                                                );
                                              },
                                              film: Film(
                                                name:
                                                    members[index].episode.name,
                                                mediaType: "episode",
                                                firstAirDate: members[index]
                                                    .episode
                                                    .airDate,
                                                backdropPath: members[index]
                                                    .episode
                                                    .stillPath,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: CardBackdrop(
                                              // film: snapshot.data!.items[index],
                                              film: members[index].film,
                                            ),
                                          );
                                        }
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
                                return const Column(
                                  children: [CircularProgressIndicator()],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const SizedBox();
                }

                // By default, show a loading spinner.
                return const Column(
                  children: [CircularProgressIndicator()],
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AdvanceSearchView.routeName,
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: MyFilmAppColors.header,
                padding: const EdgeInsets.only(left: 20, bottom: 15, top: 15),
                child: const Text(
                  "Tìm kiếm thêm",
                  style: TextStyle(
                    color: MyFilmAppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
