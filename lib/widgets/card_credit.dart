import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/person.dart';

class CardCredit extends StatefulWidget {
  final Person? person;

  const CardCredit({
    super.key,
    Person? person,
  }) : person = person ?? const Person();

  @override
  State<CardCredit> createState() => _CardCreditState();
}

class _CardCreditState extends State<CardCredit> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.only(left: 11.0),
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
