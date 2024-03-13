import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';

class ItemInfo extends StatefulWidget {
  final Film film;

  ItemInfo({
    super.key,
    Film? film,
  }) : film = film ?? Film();

  @override
  State<ItemInfo> createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.film.mediaType == "tv")
          Row(
            children: [
              Text(
                (widget.film.firstAirDate == "")
                    ? ""
                    : widget.film.firstAirDate.substring(0, 4),
                style: const TextStyle(
                  color: MyFilmAppColors.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 6.0),
              const Icon(
                Icons.circle,
                size: 3,
                color: MyFilmAppColors.white,
              ),
              const SizedBox(width: 8.0),
              SvgPicture.asset(
                'assets/images/tv_active.svg',
                width: 13,
              ),
              const SizedBox(width: 8.0),
              const Icon(
                Icons.circle,
                size: 3,
                color: MyFilmAppColors.white,
              ),
              const SizedBox(width: 8.0),
              const Text(
                "Tv series",
                style: TextStyle(
                  color: MyFilmAppColors.white,
                  fontSize: 12,
                ),
              )
            ],
          )
        else if (widget.film.mediaType == "movie")
          Row(
            children: [
              Text(
                (widget.film.releaseDate == "")
                    ? ""
                    : widget.film.releaseDate.substring(0, 4),
                style: const TextStyle(
                  color: MyFilmAppColors.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 6.0),
              const Icon(
                Icons.circle,
                size: 3,
                color: MyFilmAppColors.white,
              ),
              const SizedBox(width: 8.0),
              SvgPicture.asset(
                'assets/images/movie_active.svg',
                width: 13,
              ),
              const SizedBox(width: 8.0),
              const Icon(
                Icons.circle,
                size: 3,
                color: MyFilmAppColors.white,
              ),
              const SizedBox(width: 8.0),
              const Text(
                "Movie",
                style: TextStyle(
                  color: MyFilmAppColors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        const SizedBox(
          height: 1,
        ),
        Text(
          "${widget.film.title}${widget.film.name}",
          style: const TextStyle(
            color: MyFilmAppColors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
