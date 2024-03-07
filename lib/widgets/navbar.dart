import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/screens/auth/profile.dart';
import 'package:myfilmapp/widgets/logo_app.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String? currentPage;
  final bool? backButton;
  final String? title;
  const Navbar({Key? key, this.currentPage, this.backButton, this.title})
      : super(key: key);

  final double _prefferedHeight = 100.0;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(_prefferedHeight);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget._prefferedHeight,
      decoration: const BoxDecoration(color: MyFilmAppColors.header),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: !(widget.backButton ?? false)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const LogoApp(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (widget.currentPage != "Home") {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                          child: (widget.currentPage == "Home")
                              ? SvgPicture.asset(
                                  'assets/images/home_active.svg',
                                  height: 25,
                                )
                              : SvgPicture.asset(
                                  'assets/images/home_main.svg',
                                  height: 25,
                                ),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            if (widget.currentPage != "Movie") {
                              Navigator.pushReplacementNamed(context, '/movie');
                            }
                          },
                          child: (widget.currentPage == "Movie")
                              ? SvgPicture.asset(
                                  'assets/images/movie_active.svg',
                                  height: 25,
                                )
                              : SvgPicture.asset(
                                  'assets/images/movie_main.svg',
                                  height: 25,
                                ),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            if (widget.currentPage != "Tv") {
                              Navigator.pushReplacementNamed(context, '/tv');
                            }
                          },
                          child: (widget.currentPage == "Tv")
                              ? SvgPicture.asset(
                                  'assets/images/tv_active.svg',
                                  height: 25,
                                )
                              : SvgPicture.asset(
                                  'assets/images/tv_main.svg',
                                  height: 25,
                                ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()),
                        );
                      },
                      child: Image.asset(
                        'assets/images/image-avatar.png',
                        width: 40,
                      ),
                    ),
                  ],
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
                            widget.title ?? "True Detective",
                            style: const TextStyle(
                              color: MyFilmAppColors.white,
                              fontSize: 30,
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
                ),
        ),
      ),
    );
  }
}
