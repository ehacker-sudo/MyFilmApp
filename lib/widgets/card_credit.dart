import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/person.dart';
import 'package:myfilmapp/screens/detail/person_detail.dart';

class CardCredit extends StatefulWidget {
  final Person? person;

  CardCredit({
    super.key,
    Person? person,
  }) : person = person ?? Person();

  @override
  State<CardCredit> createState() => _CardCreditState();
}

class _CardCreditState extends State<CardCredit> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          PersonDetail.routeName,
          arguments: widget.person,
        );
      },
      child: SizedBox(
        width: 180,
        child: Column(
          children: [
            Image.network(
              "https://image.tmdb.org/t/p/w500/${widget.person?.profilePath}",
              height: 180 * 700 / 500,
              width: 180,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${widget.person?.name}",
                  style: const TextStyle(
                    color: MyFilmAppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${widget.person?.character}",
                  style: const TextStyle(
                      color: MyFilmAppColors.gray,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
