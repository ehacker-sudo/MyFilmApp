import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/screens/auth/profile.dart';
import 'package:myfilmapp/screens/search/search.dart';
import 'package:myfilmapp/widgets/logo_app.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final bool backButton;
  final bool searchBar;
  final String title;
  final bool rotatedLogo;

  const Navbar({
    super.key,
    bool? backButton,
    bool? searchBar,
    String? title,
    bool? rotatedLogo,
  })  : title = title ?? "True Detective",
        backButton = backButton ?? false,
        searchBar = searchBar ?? false,
        rotatedLogo = rotatedLogo ?? false;

  final double _prefferedHeight = 90.0;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(_prefferedHeight);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1,
      child: Container(
        height: widget._prefferedHeight,
        decoration: const BoxDecoration(color: MyFilmAppColors.body),
        child: SafeArea(
          child: widget.backButton
              ? widget.searchBar
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 2.0,
                        right: 2.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            width: 30,
                            child: Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: MyFilmAppColors.white,
                                  size: 25,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 40,
                                    child: TextField(
                                      cursorColor: MyFilmAppColors.white,
                                      onTap: () {},
                                      onChanged: (String text) {},
                                      controller: null,
                                      autofocus: true,
                                      textAlignVertical:
                                          const TextAlignVertical(y: 0.9),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: MyFilmAppColors.white),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFF404040),
                                        prefixIcon: Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: [
                                            SizedBox(
                                              width: 30,
                                              child: SvgPicture.asset(
                                                'assets/images/prefix_search_outline.svg',
                                                width: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                        suffixIcon: const Icon(Icons.clear),
                                        hintText:
                                            'Tìm kiếm phim, diễn viên , ...',
                                        hintStyle: const TextStyle(
                                          fontSize: 15,
                                          color: MyFilmAppColors.gray,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            width: 0.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            width: 0.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Stack(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: FractionallySizedBox(
                            widthFactor: 0.7,
                            alignment: AlignmentDirectional.center,
                            child: Center(
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                  color: MyFilmAppColors.white,
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          width: 30,
                          child: Center(
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: MyFilmAppColors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    )
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const LogoApp(
                        width: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (BuildContext context, _, __) {
                                return const Search();
                              },
                              transitionsBuilder: (_,
                                  Animation<double> animation,
                                  __,
                                  Widget child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 25,
                          child: SvgPicture.asset(
                            'assets/images/search_outline.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
