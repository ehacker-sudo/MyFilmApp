import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';
import 'package:myfilmapp/widgets/navbar.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        backButton: true,
        searchBar: true,
      ),
      body: Container(
        decoration: const BoxDecoration(color: MyFilmAppColors.body),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: const Text(
                    "Đề xuât",
                    style: TextStyle(
                      color: MyFilmAppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 2,
                  children: <Widget>[
                    CardBackdrop(
                      film: Film(
                        backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                        title: "True Detective",
                      ),
                    ),
                    CardBackdrop(
                      film: Film(
                        backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                        title: "True Detective",
                      ),
                    ),
                    CardBackdrop(
                      film: Film(
                        backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                        title: "True Detective",
                      ),
                    ),
                    CardBackdrop(
                      film: Film(
                        backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                        title: "True Detective",
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
