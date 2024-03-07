import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/episode/episode.dart';

class CardHorizontal extends StatefulWidget {
  const CardHorizontal({Key? key}) : super(key: key);

  @override
  State<CardHorizontal> createState() => _CardHorizontalState();
}

class _CardHorizontalState extends State<CardHorizontal> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Episode()),
        );
      },
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.2,
                height: (MediaQuery.of(context).size.width * 500) / (2.2 * 750),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "asasasas",
                      style: TextStyle(
                        color: MyFilmAppColors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: MyFilmAppColors.white,
                            ),
                            Text(
                              "4.444",
                              style: TextStyle(
                                  color: MyFilmAppColors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Text(
                          "2019",
                          style: TextStyle(
                            color: MyFilmAppColors.white,
                          ),
                        ),
                        Text(
                          "21m",
                          style: TextStyle(
                            color: MyFilmAppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Text(
            "asaaaaaaaaaaaaaaaaaaaaaaaaaaaasasaasasaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            style: TextStyle(
              color: MyFilmAppColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}
