import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';

class DrawerTile extends StatefulWidget {
  final String title;
  final Function() onTap;
  final bool isSelected;

  const DrawerTile({
    super.key,
    String? title,
    Function()? onTap,
    bool? isSelected,
    Color? iconColor,
  })  : title = title ?? "",
        onTap = onTap ?? defaultOnTap,
        isSelected = isSelected ?? false;

  @override
  State<DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  bool itemIsHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (isHover) {
        setState(() {
          itemIsHover = isHover;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color:
              itemIsHover ? MyFilmAppColors.itemActive : MyFilmAppColors.header,
          border: Border(
            left: BorderSide(
              color: widget.isSelected
                  ? MyFilmAppColors.submain
                  : itemIsHover
                      ? MyFilmAppColors.itemActive
                      : MyFilmAppColors.header,
              width: 3.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                letterSpacing: .4,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: MyFilmAppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Function defaultOnTap() {
  return () {
    print("On Tap");
  };
}
