import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';
import 'package:myfilmapp/widgets/card_poster.dart';
import 'package:myfilmapp/widgets/navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Movie extends StatefulWidget {
  const Movie({super.key});

  @override
  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(
        currentPage: "Movie",
      ),
      body: Container(
        decoration: const BoxDecoration(color: MyFilmAppColors.body),
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    child: SvgPicture.asset(
                      'assets/images/search_outline.svg',
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 15),
                      child: const TextField(
                        style: TextStyle(
                            color: MyFilmAppColors.white, fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hoverColor: MyFilmAppColors.white,
                          hintText: "Tìm kiếm phim ảnh",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  height: 290,
                  child: Scrollbar(
                    thickness: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return CardBackdrop(
                          width: MediaQuery.of(context).size.width / 1.3,
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
                    "Sắp ra mắt",
                    style: TextStyle(
                      color: MyFilmAppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: Scrollbar(
                    thickness: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const CardPoster();
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
                    "Đang được công chiếu",
                    style: TextStyle(
                      color: MyFilmAppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 290,
                  child: Scrollbar(
                    thickness: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return CardBackdrop(
                          width: MediaQuery.of(context).size.width / 1.3,
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
          ],
        ),
      ),
    );
  }
}
