import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/widgets/item_info.dart';

class CardBanner extends StatefulWidget {
  final Film film;

  CardBanner({
    super.key,
    Film? film,
  }) : film = film ?? Film();

  @override
  State<CardBanner> createState() => _CardBannerState();
}

class _CardBannerState extends State<CardBanner> {
  late bool showNavigationDrawer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 450;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          FilmDetail.routeName,
          arguments: widget.film,
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: (widget.film.backdropPath != "")
                ? Image.network(
                    "https://image.tmdb.org/t/p/w500${widget.film.backdropPath}",
                    height: 250,
                    width: 250 * 1.778,
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    "assets/images/film_horizontal_placeholder.svg",
                    height: 250,
                    width: 250 * 1.778,
                    fit: BoxFit.cover,
                  ),
          ),
          Container(
            height: 250,
            width: 250 * 1.778,
            decoration: const BoxDecoration(
              // color: Color(0x33000000),
              gradient: LinearGradient(
                colors: [
                  Color(0x00000000),
                  Color(0x0D000000),
                  Color(0x33000000),
                  Color(0x80000000),
                ],
                begin: Alignment.topCenter, //begin of the gradient color
                end: Alignment.bottomCenter, //end of the gradient color
                // stops: [0, 0.2, 0.5, 0.8] //stops for individual color
                //set the stops number equal to numbers of color
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
          ),
          Container(
            height: 300,
            alignment: AlignmentDirectional.bottomCenter,
            padding: const EdgeInsets.all(10.0),
            child: ItemInfo(
              film: widget.film,
            ),
          ),
        ],
      ),
    );
  }
}
