import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/widgets/card_backdrop.dart';

class MyListView extends StatefulWidget {
  final Future future;
  final Function(AsyncSnapshot<dynamic> snapshot) listBuilder;
  final Widget Function(List? items) myItemBuilder;

  const MyListView({
    super.key,
    required this.future,
    required this.listBuilder,
    required this.myItemBuilder,
  });
  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // List items = snapshot.data!.items;
          List items = widget.listBuilder(snapshot);
          if (items.isNotEmpty) {
            return widget.myItemBuilder(items);
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
