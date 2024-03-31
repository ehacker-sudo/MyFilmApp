import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';

class CardVertical extends StatefulWidget {
  final int id;
  final String posterPath;
  final String name;
  final String overview;
  final double voteAverage;
  final String airDate;
  final int episodeCount;
  final Function() onTap;
  const CardVertical({
    int? id,
    String? posterPath,
    String? name,
    String? overview,
    double? voteAverage,
    String? airDate,
    int? episodeCount,
    Function()? onTap,
  })  : name = name ?? 'One Piece',
        id = id ?? 0,
        posterPath = posterPath ?? '/vuZrgFo96FGiTJC489aPtWyTDt2.jpg',
        voteAverage = voteAverage ?? 0.0,
        episodeCount = episodeCount ?? 0,
        airDate = airDate ?? '1999',
        overview = overview ?? '',
        onTap = onTap ?? defaultOnTap;

  @override
  State<CardVertical> createState() => _CardVerticalState();
}

class _CardVerticalState extends State<CardVertical> {
  bool itemIsHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (isHover) {
        setState(() {
          itemIsHover = isHover;
        });
      },
      child: Container(
        color: MyFilmAppColors.body,
        child: Row(
          children: [
            Hero(
              tag: widget.id,
              child: SizedBox(
                width: 150 * 0.667,
                height: 150,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${widget.posterPath}',
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
                      fontSize: 20.0,
                      color: MyFilmAppColors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        (widget.airDate == '')
                            ? ''
                            : widget.airDate.substring(0, 4),
                        style: const TextStyle(
                          color: Color(0xFFC6C6C6),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'TV Series',
                        style: const TextStyle(
                          color: Color(0xFFC6C6C6),
                        ),
                      ),
                    ],
                  ),
                ],
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
    print('On Tap');
  };
}
