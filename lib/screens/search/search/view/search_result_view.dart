import 'package:flutter/material.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/model/person.dart';
import 'package:myfilmapp/screens/detail/film_detail.dart';
import 'package:myfilmapp/screens/detail/person_detail.dart';
import 'package:myfilmapp/widgets/card_vertical.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchPopulatedView extends StatelessWidget {
  final ListFilm result;
  static final yourScrollController = ScrollController();
  const SearchPopulatedView(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF3C3C3C).withOpacity(0.2),
      child: ScrollbarTheme(
        data: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(
            Colors.grey,
          ),
        ), // Here
        child: ListView.builder(
          controller: yourScrollController, // Here
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                child: CardVertical(
                  name: person.name,
                  posterPath: person.profilePath,
                  mediaType: item.mediaType,
                  overview: item.knownForDepartment,
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
                padding:
                    const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                child: CardVertical(
                  id: item.id,
                  name: '${item.name}${item.title}',
                  mediaType: item.mediaType,
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
      ),
    );
  }
}
