import 'package:flutter/material.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/widgets/item_info.dart';

class CardPoster extends StatefulWidget {
  const CardPoster({Key? key}) : super(key: key);

  @override
  State<CardPoster> createState() => _CardPosterState();
}

class _CardPosterState extends State<CardPoster> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FilmDetail()),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500/cuV2O5ZyDLHSOWzg3nLVljp1ubw.jpg",
                width: MediaQuery.of(context).size.width / 2.3,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.3,
              child: ItemInfo(
                film: Film(
                  title: "aasas",
                  releaseDate: "2014",
                  mediaType: "tv",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
