import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/api/user_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/auth.dart';
import 'package:myfilmapp/model/film.dart';

class ButtonWatchlist extends StatefulWidget {
  final Film film;

  ButtonWatchlist({
    super.key,
    Film? film,
  }) : film = film ?? Film();

  @override
  State<ButtonWatchlist> createState() => _ButtonWatchlistState();
}

class _ButtonWatchlistState extends State<ButtonWatchlist> {
  bool isSave = false;
  late Future<Member> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = AdminClient().showWatchlistUser(widget.film);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isSave) {
          } else {
            AdminClient().watchlistStore(Member(
              filmId: widget.film.id,
              mediaType: widget.film.mediaType,
              film: widget.film,
            ));
          }
          isSave = !isSave;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 10.0,
          bottom: 10.0,
        ),
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10.0,
          bottom: 10.0,
        ),
        decoration: BoxDecoration(
          color: (isSave) ? MyFilmAppColors.body : MyFilmAppColors.submain,
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          border:
              (isSave) ? Border.all(color: MyFilmAppColors.itemActive) : null,
        ),
        child: Row(
          children: [
            (isSave)
                ? const Icon(
                    Icons.check,
                    size: 20,
                    color: MyFilmAppColors.white,
                  )
                : SvgPicture.asset(
                    'assets/images/plus.svg',
                    width: 20,
                  ),
            const SizedBox(
              width: 10,
            ),
            Text(
              (isSave) ? "Đã thêm vào danh sách xem" : "Thêm vào danh sách xem",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: (isSave) ? MyFilmAppColors.white : MyFilmAppColors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
