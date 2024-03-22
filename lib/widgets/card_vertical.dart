import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';

class CardVertical extends StatefulWidget {
  final String posterPath;
  final String name;
  final String overview;
  final double voteAverage;
  final String airDate;
  final int episodeCount;
  final Function() onTap;
  const CardVertical({
    super.key,
    String? posterPath,
    String? name,
    String? overview,
    double? voteAverage,
    String? airDate,
    int? episodeCount,
    Function()? onTap,
  })  : name = name ?? "asasasas",
        posterPath = posterPath ?? "/vuZrgFo96FGiTJC489aPtWyTDt2.jpg",
        voteAverage = voteAverage ?? 0.0,
        episodeCount = episodeCount ?? 0,
        airDate = airDate ?? "",
        overview = overview ?? "",
        onTap = onTap ?? defaultOnTap;

  @override
  State<CardVertical> createState() => _CardVerticalState();
}

class _CardVerticalState extends State<CardVertical> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 150 * 0.667,
                height: 150,
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500${widget.posterPath}",
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
                            ),
                            Text(
                              "${widget.voteAverage}",
                              style: const TextStyle(
                                  color: MyFilmAppColors.white,
                                  fontWeight: FontWeight.bold),
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
                          "${widget.episodeCount} tập",
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
            widget.overview,
            style: const TextStyle(
              color: MyFilmAppColors.gray,
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
