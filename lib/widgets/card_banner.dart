import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/widgets/item_info.dart';

class CardBanner extends StatefulWidget {
  final String? backdropPath;
  final String? title;
  const CardBanner({Key? key, this.backdropPath, this.title}) : super(key: key);

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
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FilmDetail()),
          );
        },
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                "https://image.tmdb.org/t/p/original/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                height: 250,
                width: 250 * 900 / 500,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 250,
              width: 250 * 900 / 500,
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
                title: widget.title,
                releaseDate: "2014",
                mediaType: "tv",
              ),
            ),
          ],
        ),
      ),
    );
    // return Container(
    //   height: 300,
    //   width: 300 * 900 / 750,
    //   padding: const EdgeInsets.only(left: 10),
    //   child: GestureDetector(
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => const FilmDetail()),
    //       );
    //     },
    //     child: Stack(
    //       alignment: AlignmentDirectional.bottomStart,
    //       children: [
    //         ClipRRect(
    //           borderRadius: BorderRadius.circular(20.0),
    //           child: Image.network(
    //             "https://image.tmdb.org/t/p/original/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
    //             height: 300,
    //             width: 300 * 900 / 500,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         // Container(
    //         //   decoration: const BoxDecoration(
    //         //     // color: Color(0x33000000),
    //         //     gradient: LinearGradient(
    //         //       colors: [
    //         //         Color(0x00000000),
    //         //         Color(0x0D000000),
    //         //         Color(0x80000000),
    //         //       ],
    //         //       begin: Alignment.topCenter, //begin of the gradient color
    //         //       end: Alignment.bottomCenter, //end of the gradient color
    //         //       // stops: [0, 0.2, 0.5, 0.8] //stops for individual color
    //         //       //set the stops number equal to numbers of color
    //         //     ),
    //         //     borderRadius: BorderRadius.all(
    //         //       Radius.circular(20.0),
    //         //     ),
    //         //   ),
    //         // ),
    //         // Container(
    //         //   padding: const EdgeInsets.all(5),
    //         //   child: ItemInfo(
    //         //     title: widget.title,
    //         //     releaseDate: "2014",
    //         //     mediaType: "tv",
    //         //   ),
    //         // ),
    //       ],
    //     ),
    //   ),
    // );

    return Container(
      height: 300,
      width: 300 * 900 / 750,
      margin: const EdgeInsets.only(left: 10),
      color: MyFilmAppColors.submain,
    );
  }
}
