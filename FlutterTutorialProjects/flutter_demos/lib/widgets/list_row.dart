import 'package:flutter/material.dart';
import 'package:flutter_demos/model/albums_list.dart';

class ListRow extends StatelessWidget {
  //
  final Album album;
  ListRow({this.album});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            album.title,
            style: TextStyle(
              fontSize: 20.0,
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
