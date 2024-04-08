import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';

class ButtonSearch extends StatefulWidget {
  final String title;
  final Function(String title, bool isSelected) onSelected;

  const ButtonSearch({
    super.key,
    String? title,
    required this.onSelected,
  }) : title = title ?? "";

  @override
  State<ButtonSearch> createState() => _ButtonSearchState();
}

class _ButtonSearchState extends State<ButtonSearch> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // setState(() {
        //   isSelected = !isSelected;
        // });
        widget.onSelected(widget.title, isSelected);
      },
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(const EdgeInsets.only(top: 5, bottom: 5)),
        backgroundColor: MaterialStateProperty.all(
          isSelected ? MyFilmAppColors.submain : const Color(0xFF4F4F4F),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            // Change your radius here
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Text(
          widget.title,
          style: TextStyle(
            color: isSelected ? MyFilmAppColors.white : MyFilmAppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
