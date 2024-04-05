import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/view/film_destop_view.dart';
import 'package:myfilmapp/view/film_mobile_view.dart';
import 'package:myfilmapp/widgets/bottom_navigation_bar.dart';
import 'package:myfilmapp/widgets/navbar.dart';

class FilmDetail extends StatefulWidget {
  static const routeName = '/filmDetail';
  const FilmDetail({Key? key}) : super(key: key);

  @override
  State<FilmDetail> createState() => _FilmDetailState();
}

class _FilmDetailState extends State<FilmDetail> {
  late bool showNavigationDrawer;
  late ConnectionState connectionState;

  void initState() {
    // TODO: implement initState
    super.initState();
    // MyFilmAppDatabase().historyStore();
    connectionState = ConnectionState.waiting;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 1000;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Film;
    // AdminClient().historyStore(Member(
    //   mediaType: film.mediaType,
    //   film: film,
    // ));
    return Scaffold(
      backgroundColor: MyFilmAppColors.body,
      appBar: Navbar(
        backButton: true,
        title: "${args.name}${args.title}",
        onBack: () {
          if (connectionState == ConnectionState.done) {
            Navigator.pop(context);
          }
        },
      ),
      body: showNavigationDrawer
          ? FilmDestopView(
              film: args,
              onLoad: (snapShotConnectionState) {
                connectionState = snapShotConnectionState;
              },
            )
          : FilmMobileView(
              film: args,
              onLoad: (snapShotConnectionState) {
                connectionState = snapShotConnectionState;
              },
            ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
