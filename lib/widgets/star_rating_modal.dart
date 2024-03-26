import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:star_rating/star_rating.dart';

class StarRatingModal extends StatefulWidget {
  final Film film;

  StarRatingModal({
    super.key,
    Film? film,
  }) : film = film ?? Film();

  @override
  State<StarRatingModal> createState() => _StarRatingModalState();
}

class _StarRatingModalState extends State<StarRatingModal> {
  double _rating = 0.0;
  Color rateColor = MyFilmAppColors.white;
  @override
  Widget build(BuildContext context) {
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
                if (_rating != 0)
                  Container(
                    color: const Color(0x99000000),
                  ),
                if (_rating != 0)
                  Text(
                    "${_rating.toInt()}",
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
              rating: _rating,
              between: 5,
              starSize: 40,
              color: rateColor,
              onRaitingTap: (rating) {
                setState(
                  () {
                    _rating = rating;
                    rateColor = (rating == 0)
                        ? MyFilmAppColors.white
                        : MyFilmAppColors.submain;
                  },
                );
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
                debugPrint("$_rating");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: (_rating == 0)
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
          // ElevatedButton(
          //   child: const Text('Close BottomSheet'),
          //   onPressed: () => Navigator.pop(context),
          // ),
        ],
      ),
    );
  }
}
