import 'package:flutter/material.dart';
import 'package:myfilmapp/model/person.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/screens/detail/person_detail.dart';
import 'package:myfilmapp/widgets/card_vertical.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:transparent_image/transparent_image.dart';

import 'search_result.dart';

class SearchPopulatedView extends StatelessWidget {
  final SearchResult result;

  SearchPopulatedView(this.result);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: MyFilmAppColors.body,
      child: ListView.builder(
        itemCount: result.items.length,
        itemBuilder: (context, index) {
          final item = result.items[index];
          if (item.mediaType == "person") {
            Person person = Person(
              id: item.id,
              name: item.name,
              profilePath: item.profilePath,
            );
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CardVertical(
                name: person.name,
                posterPath: person.profilePath,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PersonDetail.routeName,
                    arguments: person,
                  );
                },
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: CardVertical(
                id: item.id,
                name: '${item.name}${item.title}',
                posterPath: item.posterPath,
                airDate: '${item.firstAirDate}${item.releaseDate}',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    FilmDetail.routeName,
                    arguments: item,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  void showItem(BuildContext context, SearchResultItem item) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute<Null>(
    //     builder: (BuildContext context) {
    //       return Scaffold(
    //         resizeToAvoidBottomInset: false,
    //         body: GestureDetector(
    //           onTap: () => Navigator.pop(context),
    //           child: SizedBox.expand(
    //             child: Hero(
    //               tag: item.id,
    //               child: Image.network(
    //                 'https://image.tmdb.org/t/p/w500${item.posterPath}',
    //                 width: MediaQuery.of(context).size.width,
    //                 height: 300.0,
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
