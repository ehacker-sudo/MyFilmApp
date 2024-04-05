import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/review.dart';

class CardReview extends StatefulWidget {
  final Review review;
  final EdgeInsetsGeometry margin;

  CardReview({
    super.key,
    Review? review,
    EdgeInsetsGeometry? margin,
  })  : review = review ?? Review(),
        margin = margin ?? const EdgeInsets.all(0.0);

  @override
  State<CardReview> createState() => _CardReviewState();
}

class _CardReviewState extends State<CardReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 400,
      color: MyFilmAppColors.header,
      margin: widget.margin,
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
        bottom: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.review.authorDetails.rating != 0.0)
            Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: MyFilmAppColors.submain,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "${widget.review.authorDetails.rating.toInt() + .0}",
                      style: const TextStyle(
                        color: MyFilmAppColors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          Text(
            widget.review.content,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }
}
