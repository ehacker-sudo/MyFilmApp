import 'package:flutter/material.dart';
import 'package:myfilmapp/api/user_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/auth.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:star_rating/star_rating.dart';

class MyStarRating extends StatefulWidget {
  final Film film;
  MyStarRating({
    super.key,
    Film? film,
  }) : film = film ?? Film();

  @override
  State<MyStarRating> createState() => _MyStarRatingState();
}

class _MyStarRatingState extends State<MyStarRating> {
  late double rating;
  late Future<Member> futureRate;

  @override
  void initState() {
    // TODO: implement initState

    futureRate = AdminClient().showRateUser(widget.film);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showSnackBar() {
      const snackBar = SnackBar(
        content: Text("snackbar"),
        backgroundColor: MyFilmAppColors.submain,
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return FutureBuilder<Member>(
        future: futureRate,
        builder: (context, snapshot) {
          return IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  if (snapshot.hasData) {
                    rating = snapshot.data!.rate;
                  }

                  print("Rate: ${snapshot.data!.filmId}");
                  return StarRatingModal(
                    film: widget.film,
                    futureRate: rating,
                    valueChanged: (double value) {
                      setState(() {
                        if (snapshot.hasData) {
                          futureRate = AdminClient().rateUpdate(Member(
                            film: widget.film,
                            rate: value,
                          ));
                        } else {
                          futureRate = AdminClient().rateStore(Member(
                            film: widget.film,
                            rate: value,
                          ));
                        }

                        rating = value;
                      });

                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => showSnackBar());
                    },
                  );
                },
              );
            },
            icon: (snapshot.hasData)
                ? Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: MyFilmAppColors.submain,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${snapshot.data?.rate.toInt()}/10",
                        style: const TextStyle(
                          color: MyFilmAppColors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )
                : const Icon(
                    Icons.star_border_outlined,
                    color: MyFilmAppColors.submain,
                    size: 40,
                  ),
          );
        });
  }
}

class StarRatingModal extends StatefulWidget {
  final Film film;
  final double futureRate;
  final Function(double text) valueChanged;
  StarRatingModal({
    super.key,
    Film? film,
    required this.valueChanged,
    required this.futureRate,
  }) : film = film ?? Film();

  @override
  State<StarRatingModal> createState() => _StarRatingModalState();
}

class _StarRatingModalState extends State<StarRatingModal> {
  late double _futureRate;
  @override
  void initState() {
    _futureRate = widget.futureRate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<Member>(
    //     future: _futureRate,
    //     builder: (context, snapshot) {
    //       // if (snapshot.hasData) {
    //       //   currentRate = snapshot.data!.rate;
    //       // }
    return Container(
      // height: 2000,
      color: MyFilmAppColors.body,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 250 * 0.667,
            height: 250,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Image.network(
                  "https://image.tmdb.org/t/p/w500${widget.film.posterPath}",
                  // width: MediaQuery.of(context).size.width / 2.5,
                ),
                if (_futureRate != 0)
                  Container(
                    color: const Color(0x99000000),
                  ),
                if (_futureRate != 0.0)
                  Text(
                    "${_futureRate.toInt()}",
                    style: const TextStyle(
                      fontSize: 70,
                      color: MyFilmAppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "${widget.film.name}${widget.film.title}",
              style:
                  const TextStyle(fontSize: 20, color: MyFilmAppColors.white),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            alignment: AlignmentDirectional.center,
            child: StarRating(
              mainAxisAlignment: MainAxisAlignment.center,
              length: 10,
              rating: _futureRate,
              between: 5,
              starSize: 40,
              color: (_futureRate == 0.0)
                  ? MyFilmAppColors.white
                  : MyFilmAppColors.submain,
              onRaitingTap: (rating) {
                setState(() {
                  _futureRate = rating;
                });
              },
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                widget.valueChanged(_futureRate);

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: (_futureRate == 0)
                    ? MyFilmAppColors.header
                    : MyFilmAppColors.submain,
                textStyle: const TextStyle(fontSize: 14.0),
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                ),
                elevation: 5,
              ),
              child: const Text(
                "Đánh giá",
                style: TextStyle(
                  color: MyFilmAppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
    // });
  }
}
