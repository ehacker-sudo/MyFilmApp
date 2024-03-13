import 'package:flutter/material.dart';
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
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.2,
                height: (MediaQuery.of(context).size.width * 500) / (2.2 * 750),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500${widget.backdropPath}",
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
