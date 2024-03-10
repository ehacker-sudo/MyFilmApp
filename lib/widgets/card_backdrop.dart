import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/widgets/item_info.dart';

class CardBackdrop extends StatefulWidget {
  final double? height;
  final String? backdropPath;
  final String? title;
  const CardBackdrop({Key? key, this.height, this.backdropPath, this.title})
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
        width: (widget.height ?? 180) * 900 / 500,
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                height: widget.height ?? 180,
                width: (widget.height ?? 180) * 900 / 500,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              width: (widget.height ?? 200) * 900 / 500,
              height: 50,
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
