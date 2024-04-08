import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';

class CardOverview extends StatefulWidget {
  final Film film;

  CardOverview({
    super.key,
    Film? film,
  }) : film = film ?? Film();

  @override
  State<CardOverview> createState() => _CardOverviewState();
}

class _CardOverviewState extends State<CardOverview> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.film.overview.length > 250) {
      firstHalf = widget.film.overview.substring(0, 250);
      secondHalf =
          widget.film.overview.substring(250, widget.film.overview.length);
    } else {
      firstHalf = widget.film.overview;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Giới thiệu phim",
          style: TextStyle(
            color: MyFilmAppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        secondHalf.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstHalf,
                    style: const TextStyle(
                      color: MyFilmAppColors.longText,
                    ),
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    flag ? ("$firstHalf...") : (firstHalf + secondHalf),
                    style: const TextStyle(
                      color: MyFilmAppColors.longText,
                    ),
                  ),
                  if (flag)
                    Container(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            flag = !flag;
                          });
                        },
                        child: const Text(
                          "Xem thêm",
                          style: TextStyle(
                            color: MyFilmAppColors.submain,
                          ),
                        ),
                      ),
                    )
                ],
              ),
      ],
    );
  }
}
