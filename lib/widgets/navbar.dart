import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/screens/search/search.dart';
import 'package:myfilmapp/screens/search/search/search_screen.dart';
import 'package:myfilmapp/widgets/logo_app.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final bool backButton;
  final bool searchBar;
  final Function(String text) onSubmit;
  final Function(String text) onChanged;
  final String title;
  final bool rotatedLogo;
  final bool mobileMode;

  Navbar({
    super.key,
    bool? backButton,
    bool? searchBar,
    Function(String text)? onSubmit,
    Function(String text)? onChanged,
    String? title,
    bool? rotatedLogo,
    bool? mobileMode,
  })  : title = title ?? "True Detective",
        backButton = backButton ?? false,
        searchBar = searchBar ?? false,
        onSubmit = onSubmit ?? defaultOnTap,
        onChanged = onChanged ?? defaultOnTap,
        rotatedLogo = rotatedLogo ?? false,
        mobileMode = mobileMode ?? false;

  final double _prefferedHeight = 90.0;
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(_prefferedHeight);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  String searchText = "";
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget._prefferedHeight,
      decoration: BoxDecoration(
        color: (widget.searchBar)
            ? MyFilmAppColors.body
            : MyFilmAppColors.body.withAlpha(200),
      ),
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
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25.0),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 40,
                                  child: TextField(
                                    cursorColor: MyFilmAppColors.white,
                                    onChanged: (text) {
                                      setState(() {
                                        searchText = text;
                                        widget.onChanged(text);
                                      });
                                    },
                                    onSubmitted: widget.onSubmit,
                                    controller: searchController,
                                    autofocus: true,
                                    textAlignVertical:
                                        const TextAlignVertical(y: 0.9),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: MyFilmAppColors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xFF404040),
                                      prefixIcon: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          SizedBox(
                                            width: 28,
                                            child: SvgPicture.asset(
                                              'assets/images/prefix_search_outline.svg',
                                              width: 28,
                                            ),
                                          ),
                                        ],
                                      ),
                                      suffixIcon: (searchText != "")
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  searchController.text = "";
                                                  searchText = "";
                                                  widget.onChanged("");
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Color(0xFF9A9A9A),
                                              ),
                                            )
                                          : null,
                                      hintText:
                                          'Tìm kiếm phim, diễn viên , ...',
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF9A9A9A),
                                        fontWeight: FontWeight.w500,
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
                    Row(
                      children: [
                        if (!widget.mobileMode)
                          IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Icon(
                              Icons.menu,
                              color: MyFilmAppColors.white,
                              size: 30,
                            ),
                          ),
                        const LogoApp(
                          width: 40,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (BuildContext context, _, __) {
                              return const SearchScreen();
                            },
                            transitionsBuilder: (_, Animation<double> animation,
                                __, Widget child) {
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
    );
  }
}

var defaultOnTap = (String text) {};
