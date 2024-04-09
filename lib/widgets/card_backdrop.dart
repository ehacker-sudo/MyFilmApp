import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/widgets/item_info.dart';

class CardBackdrop extends StatefulWidget {
  final double height;
  final Film film;
  final Function() onTap;
  CardBackdrop({
    super.key,
    double? height,
    Film? film,
    Function()? onTap,
  })  : height = height ?? 180,
        film = film ?? Film(),
        onTap = onTap ?? defaultOnTap;

  @override
  State<CardBackdrop> createState() => _CardBackdropState();
}

class _CardBackdropState extends State<CardBackdrop> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap == defaultOnTap) {
          Navigator.pushNamed(
            context,
            FilmDetail.routeName,
            arguments: widget.film,
          );
        } else {
          widget.onTap();
        }
      },
      child: SizedBox(
        width: widget.height * 900 / 500,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: (widget.film.backdropPath != "")
                  ? Image.network(
                      "https://image.tmdb.org/t/p/w500${widget.film.backdropPath}",
                      height: widget.height,
                      width: widget.height * 900 / 500,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      "assets/images/film_horizontal_placeholder.svg",
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

Function defaultOnTap() {
  return () {
    print("On Tap");
  };
}
