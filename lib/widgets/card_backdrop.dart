import 'package:flutter/material.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/widgets/item_info.dart';

class CardBackdrop extends StatefulWidget {
  final double? width;
  final String? backdropPath;
  final String? title;
  const CardBackdrop({Key? key, this.width, this.backdropPath, this.title})
      : super(key: key);

  @override
  State<CardBackdrop> createState() => _CardBackdropState();
}

class _CardBackdropState extends State<CardBackdrop> {
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
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                width: widget.width ?? MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              width: widget.width ?? MediaQuery.of(context).size.width,
              child: ItemInfo(
                title: widget.title,
                releaseDate: "2014",
                mediaType: "tv",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
