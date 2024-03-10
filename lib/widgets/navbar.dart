import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/screens/auth/profile.dart';
import 'package:myfilmapp/screens/search/search.dart';
import 'package:myfilmapp/widgets/logo_app.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String? currentPage;
  final bool? backButton;
  final bool? searchBar;
  final String? title;
  final bool? rotatedLogo;
  const Navbar(
      {Key? key,
      this.currentPage,
      this.backButton,
      this.title,
      this.searchBar,
      this.rotatedLogo})
      : super(key: key);

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
        height: !(widget.backButton ?? false)
            ? widget._prefferedHeight
            : widget._prefferedHeight,
        decoration: const BoxDecoration(color: MyFilmAppColors.body),
        child: SafeArea(
          child: !(widget.backButton ?? false)
              ? Padding(
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const Search()),
                          // );
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (BuildContext context, _, __) {
                                return Search();
                              }, transitionsBuilder: (_,
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
                              }));
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
                )
              : Padding(
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
                          padding:
                              const EdgeInsets.only(left: 25.0, right: 25.0),
                          // child: TextField(
                          //   cursorColor: MyFilmAppColors.submain,
                          //   style: const TextStyle(
                          //       fontSize: 13.0, color: MyFilmAppColors.white),
                          //   // textAlignVertical: const TextAlignVertical(y: 0.6),
                          //   decoration: InputDecoration(
                          //       filled: true,
                          //       fillColor: MyFilmAppColors.gray,
                          //       hintStyle: const TextStyle(
                          //         color: MyFilmAppColors.gray,
                          //       ),
                          //       suffixIcon: null,
                          //       // prefixIcon: prefixIcon,
                          //       enabledBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10.0),
                          //         // borderSide: BorderSide(
                          //         //     color: borderColor ?? NowUIColors.border,
                          //         //     width: 1.0,
                          //         //     style: BorderStyle.solid),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10.0),
                          //         // borderSide: BorderSide(
                          //         //     color: borderColor ?? NowUIColors.border,
                          //         //     width: 1.0,
                          //         //     style: BorderStyle.solid),
                          //       ),
                          //       hintText:
                          //           "Tìm kiếm phim ảnh ,phim truyền hình hoặc diễn viên  "),
                          // ),
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
                                      alignment: AlignmentDirectional.center,
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
                                    hintText: 'Tìm kiếm phim, diễn viên , ...',
                                    hintStyle: const TextStyle(
                                      fontSize: 15,
                                      color: MyFilmAppColors.gray,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        width: 0.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
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
                ),
        ),
      ),
    );
  }
}
