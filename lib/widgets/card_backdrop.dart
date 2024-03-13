import 'package:flutter/material.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/widgets/item_info.dart';

class CardBackdrop extends StatefulWidget {
  final double height;
  final Film film;

  CardBackdrop({
    super.key,
    double? height,
    Film? film,
  })  : height = height ?? 180,
        film = film ?? Film();

  @override
  State<CardBackdrop> createState() => _CardBackdropState();
}

class _CardBackdropState extends State<CardBackdrop> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          FilmDetail.routeName,
          arguments: widget.film,
        );
      },
      child: Container(
        width: widget.height * 900 / 500,
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${widget.film.backdropPath}",
                height: widget.height,
                width: widget.height * 900 / 500,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              width: widget.height * 900 / 500,
              height: 50,
              child: ItemInfo(
                film: widget.film,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
