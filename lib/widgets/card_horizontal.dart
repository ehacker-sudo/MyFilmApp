import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/constants/theme.dart';

class CardHorizontal extends StatefulWidget {
  final String backdropPath;
  final String name;
  final String overview;
  final double voteAverage;
  final String airDate;
  final int episodeCount;
  final Function() onTap;
  const CardHorizontal({
    super.key,
    String? backdropPath,
    String? name,
    String? overview,
    double? voteAverage,
    String? airDate,
    int? episodeCount,
    Function()? onTap,
  })  : name = name ?? "asasasas",
        backdropPath = backdropPath ?? "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
        voteAverage = voteAverage ?? 0.0,
        episodeCount = episodeCount ?? 0,
        airDate = airDate ?? "",
        overview = overview ?? "",
        onTap = onTap ?? defaultOnTap;

  @override
  State<CardHorizontal> createState() => _CardHorizontalState();
}

class _CardHorizontalState extends State<CardHorizontal> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  width: 100 * 1.778,
                  height: 100,
                  child: (widget.backdropPath != "")
                      ? Image.network(
                          "https://image.tmdb.org/t/p/w500${widget.backdropPath}",
                          fit: BoxFit.cover,
                        )
                      : SvgPicture.asset(
                          "assets/images/film_horizontal_placeholder.svg",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: MyFilmAppColors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: MyFilmAppColors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              "${widget.voteAverage}",
                              style: const TextStyle(
                                fontSize: 13.0,
                                color: MyFilmAppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Text(
                          (widget.airDate == "")
                              ? ""
                              : widget.airDate.substring(0, 4),
                          style: const TextStyle(
                            color: MyFilmAppColors.white,
                          ),
                        ),
                        Text(
                          "${widget.episodeCount} m",
                          style: const TextStyle(
                            color: MyFilmAppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            maxLines: 3,
            widget.overview,
            style: const TextStyle(
              color: MyFilmAppColors.gray,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

Function defaultOnTap() {
  return () {
    print("On Tap");
  };
}
