import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';

class InkWellSearch extends StatefulWidget {
  final String title;
  final String img;
  final Function(bool) onTap;
  const InkWellSearch({
    super.key,
    this.title = "",
    required this.img,
    required this.onTap,
  });

  @override
  State<InkWellSearch> createState() => _InkWellSearchState();
}

class _InkWellSearchState extends State<InkWellSearch> {
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            // _visible = !_visible;
            _visible = false;
          });
          widget.onTap(_visible);
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          height: (MediaQuery.of(context).size.width / 2.5) / (1280 / 854),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "assets/images/monster.jpg",
                  width: MediaQuery.of(context).size.width / 2.5,
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                // If the widget is visible, animate to 0.0 (invisible).
                // If the widget is hidden, animate to 1.0 (fully visible).
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 150),
                // The green box must be a child of the AnimatedOpacity widget.
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0x99000000),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                // If the widget is visible, animate to 0.0 (invisible).
                // If the widget is hidden, animate to 1.0 (fully visible).
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 150),
                // The green box must be a child of the AnimatedOpacity widget.
                child: const Text(
                  "Phim ảnh",
                  style: TextStyle(
                    fontSize: 30,
                    color: MyFilmAppColors.white,
                    fontWeight: FontWeight.bold,
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
