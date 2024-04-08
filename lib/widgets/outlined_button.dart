import 'package:flutter/material.dart';
import 'package:myfilmapp/model/search.dart';
import 'package:myfilmapp/screens/search/advance_search/advance_search.dart';

class MyOutlinedButton extends StatefulWidget {
  final String name;
  final MySearch mySearch;
  final EdgeInsetsGeometry margin;

  MyOutlinedButton({
    super.key,
    String? name,
    MySearch? mySearch,
    EdgeInsetsGeometry? margin,
  })  : name = name ?? "",
        margin = margin ?? const EdgeInsets.all(0.0),
        mySearch = mySearch ?? MySearch();

  @override
  State<MyOutlinedButton> createState() => _MyOutlinedButtonState();
}

class _MyOutlinedButtonState extends State<MyOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AdvanceSearch.routeName,
            arguments: widget.mySearch,
          );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        child: Text(
          widget.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
