import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';

class SearchEmptyView extends StatelessWidget {
  SearchEmptyView();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyFilmAppColors.body,
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.warning,
            color: Colors.yellow[200],
            size: 80.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              'Không có kết quả',
              style: TextStyle(color: Colors.yellow[100]),
            ),
          )
        ],
      ),
    );
  }
}
