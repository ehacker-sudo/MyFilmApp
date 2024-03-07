import 'package:flutter/material.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/widgets/item_info.dart';

class CardBanner extends StatelessWidget {
  final String? backdropPath;
  final String? title;
  const CardBanner({Key? key, this.backdropPath, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.width * 500 / 750,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10),
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
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                // color: Color(0x33000000),
                gradient: LinearGradient(
                  colors: [
                    Color(0x00000000),
                    Color(0x0D000000),
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
              padding: const EdgeInsets.all(5),
              child: ItemInfo(
                title: title,
                releaseDate: "2014",
                mediaType: "tv",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
