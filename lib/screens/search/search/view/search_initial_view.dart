import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';

class SearchInitialView extends StatelessWidget {
  const SearchInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      color: MyFilmAppColors.body,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info, color: Colors.green[200], size: 80.0),
          Container(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Nhập để tìm kiếm',
              style: TextStyle(
                color: Colors.green[100],
              ),
            ),
          )
        ],
      ),
    );
  }
}
