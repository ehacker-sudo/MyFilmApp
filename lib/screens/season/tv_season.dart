import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/widgets/card_horizontal.dart';
import 'package:myfilmapp/widgets/navbar.dart';

class TvSeason extends StatefulWidget {
  const TvSeason({Key? key}) : super(key: key);

  @override
  State<TvSeason> createState() => _TvSeasonState();
}

class _TvSeasonState extends State<TvSeason> {
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        backButton: true,
      ),
      body: Container(
        decoration: const BoxDecoration(color: MyFilmAppColors.body),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Season",
                style: TextStyle(color: MyFilmAppColors.gray),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          currentPage = index + 1;
                        },
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (index + 1 == currentPage)
                                ? MyFilmAppColors.submain
                                : MyFilmAppColors.body,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (content, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: const CardHorizontal(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
