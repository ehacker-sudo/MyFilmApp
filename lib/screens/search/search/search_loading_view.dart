import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';

class SearchLoadingView extends StatelessWidget {
  SearchLoadingView();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyFilmAppColors.body,
      alignment: FractionalOffset.center,
      child: const CircularProgressIndicator(),
    );
  }
}
