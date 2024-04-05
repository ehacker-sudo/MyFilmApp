import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';

class ListViewHorizontal extends StatefulWidget {
  final Future future;
  final String title;
  final EdgeInsetsGeometry padding;

  const ListViewHorizontal({
    super.key,
    required this.future,
    String? title,
    EdgeInsetsGeometry? padding,
  })  : title = title ?? "",
        padding = padding ?? const EdgeInsets.all(0.0);
  @override
  State<ListViewHorizontal> createState() => _ListViewHorizontalState();
}

class _ListViewHorizontalState extends State<ListViewHorizontal> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List items = snapshot.data!.items;
          if (items.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 180 + 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: widget.padding,
                        child: CardBackdrop(
                          film: items[index],
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return const SizedBox(
              height: 15,
            );
          }
        } else if (snapshot.hasError) {
          return Text(
            '${snapshot.error}',
            style: const TextStyle(color: MyFilmAppColors.white),
          );
        }

        // By default, show a loading spinner.
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
