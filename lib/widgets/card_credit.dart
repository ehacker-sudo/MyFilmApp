import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';

class CardCredit extends StatefulWidget {
  final String? profilePath;
  final String? name;
  const CardCredit({Key? key, this.profilePath, this.name}) : super(key: key);

  @override
  State<CardCredit> createState() => _CardCreditState();
}

class _CardCreditState extends State<CardCredit> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(left: 11.0),
        child: Column(
          children: [
            Image.network(
              "https://image.tmdb.org/t/p/w500/${widget.profilePath}",
              width: MediaQuery.of(context).size.width / 3.0,
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.name ?? "",
                  style: const TextStyle(
                    color: MyFilmAppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "asasas",
                  style: TextStyle(
                      color: MyFilmAppColors.gray,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
