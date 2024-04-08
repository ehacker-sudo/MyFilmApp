import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';

class ListViewHorizontal extends StatefulWidget {
  final double between;
  final double height;
  final List items;
  final String title;
  final Axis axis;
  final EdgeInsetsGeometry padding;
  final Widget? Function(BuildContext context, int index) myItemBuilder;

  ListViewHorizontal({
    super.key,
    double? between,
    double? height,
    List? items,
    String? title,
    EdgeInsetsGeometry? padding,
    this.axis = Axis.horizontal,
    Widget? Function(BuildContext context, int index)? myItemBuilder,
  })  : height = height ?? (180 + 50),
        between = between ?? 15,
        title = title ?? "",
        items = items ?? [],
        padding = padding ?? const EdgeInsets.all(0.0),
        myItemBuilder = myItemBuilder ?? defaultItemBuilder;
  @override
  State<ListViewHorizontal> createState() => _ListViewHorizontalState();
}

class _ListViewHorizontalState extends State<ListViewHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: widget.padding,
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: MyFilmAppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: widget.between,
        ),
        Container(
          height: widget.height,
          alignment: AlignmentDirectional.centerStart,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: widget.axis,
            itemCount: widget.items.length,
            itemBuilder: widget.myItemBuilder,
          ),
        )
      ],
    );
  }
}
