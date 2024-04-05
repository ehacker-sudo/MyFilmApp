import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/api/user_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/auth.dart';
import 'package:myfilmapp/model/user.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ButtonWatchlist extends StatefulWidget {
  final Member member;
  ButtonWatchlist({
    super.key,
    Member? member,
  }) : member = member ?? Member();

  @override
  State<ButtonWatchlist> createState() => _ButtonWatchlistState();
}

class _ButtonWatchlistState extends State<ButtonWatchlist> {
  late Future<Member> _futureWatchlist;
  late Future<User> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureWatchlist = AdminClient().showWatchlistUser(widget.member);
    _futureUser = AdminClient().loginUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Member>(
      future: _futureWatchlist,
      builder: (context, snapshot) {
        // if (snapshot.hasData || snapshot.hasError) {
        return InkWell(
          onTap: () {
            _futureUser.then((value) {
              if (snapshot.hasData) {
                setState(() {
                  _futureWatchlist =
                      AdminClient().watchlistDestroy(widget.member);
                });
              } else {
                setState(() {
                  _futureWatchlist =
                      AdminClient().watchlistStore(widget.member);
                });
              }
            }).catchError((err) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.warning,
                title: '',
                text: 'Hãy đăng nhập để tạo danh sách xem',
              );
            });
          },
          child: Container(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 10.0,
              bottom: 10.0,
            ),
            decoration: BoxDecoration(
              color: (snapshot.hasData)
                  ? MyFilmAppColors.body
                  : MyFilmAppColors.submain,
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
              border: (snapshot.hasData)
                  ? Border.all(color: MyFilmAppColors.itemActive)
                  : null,
            ),
            child: Row(
              children: [
                (snapshot.hasData)
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
                  (snapshot.hasData)
                      ? "Đã thêm vào danh sách xem"
                      : "Thêm vào danh sách xem",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: (snapshot.hasData)
                        ? MyFilmAppColors.white
                        : MyFilmAppColors.black,
                  ),
                )
              ],
            ),
          ),
        );
        // }
      },
    );
  }
}
