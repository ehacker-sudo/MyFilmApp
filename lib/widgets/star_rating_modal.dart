import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
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
  double number = 0.0;
  toggleIconState(double value) {
    setState(() {
      // toggleIcon = value;
      number = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return StarRatingModal(
              film: widget.film,
              number: number,
              valueChanged: toggleIconState,
            );
          },
        );
      },
      icon: (number != 0.0)
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
                  "${number.toInt()}/10",
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
  }
}

class StarRatingModal extends StatefulWidget {
  final Film film;
  final double number;
  final ValueChanged<double> valueChanged;
  StarRatingModal({
    super.key,
    Film? film,
    required this.valueChanged,
    required this.number,
  }) : film = film ?? Film();

  @override
  State<StarRatingModal> createState() => _StarRatingModalState();
}

class _StarRatingModalState extends State<StarRatingModal> {
  late double _number;
  @override
  void initState() {
    _number = widget.number;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color rateColor =
        (_number == 0.0) ? MyFilmAppColors.white : MyFilmAppColors.submain;
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
                if (_number != 0)
                  Container(
                    color: const Color(0x99000000),
                  ),
                if (_number != 0)
                  Text(
                    "${_number.toInt()}",
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
              rating: _number,
              between: 5,
              starSize: 40,
              color: rateColor,
              onRaitingTap: (rating) {
                setState(() {
                  _number = rating;
                });
                // widget.valueChanged(_number);
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
                widget.valueChanged(_number);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: (_number == 0)
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
  }
}
