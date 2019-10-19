import 'package:flutter/material.dart';
import 'services.dart';
import 'album.dart';
import 'gridcell.dart';
import 'details.dart';
import 'dart:async';
import 'Utility.dart';

class GridViewDemo extends StatefulWidget {
  //
  GridViewDemo() : super();

  final String title = "Home";

  @override
  GridViewDemoState createState() => GridViewDemoState();
}

class GridViewDemoState extends State<GridViewDemo> {
  //
  StreamController<int> streamController = new StreamController<int>();

  gridview(AsyncSnapshot<List<Album>> snapshot) {
    return Padding(
        padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 2.0,
            children: snapshot.data.map(
              (album) {
                return GestureDetector(
                  child: GridTile(
                    child: AlbumCell(album),
                  ),
                  onTap: () {
                    goToDetailsPage(context, album);
                  },
                );
              },
            ).toList(),
          ),
        ));
  }

  goToDetailsPage(BuildContext context, Album album) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => GridDetails(
          curAlbum: album,
        ),
      ),
    );
  }

  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 55.0,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 10.0,
              ),
              Image.asset(
                'images/apple.png',
                height: 80,
                width: 80,
                fit: BoxFit.fill,
              ),
              Text(
                'Edelsten',
                style: Utility.titleFontStyle(),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 30, 20, 0),
            child: Text(
              'Search',
              style: Utility.searchFontStyle(),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 10, 80, 0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(
                      25.0,
                    ),
                  ),
                  borderSide: new BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(
                      25.0,
                    ),
                  ),
                  borderSide: new BorderSide(color: Colors.black),
                ),
                filled: true,
                fillColor: Colors.white60,
                contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                hintText: 'Cherche un article',
              ),
              onChanged: (string) {
                //
              },
            ),
          ),
          Flexible(
            child: FutureBuilder<List<Album>>(
              future: Services.getPhotos(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }
                //
                if (snapshot.hasData) {
                  streamController.sink.add(snapshot.data.length);
                  // gridview
                  return gridview(snapshot);
                }
                return circularProgress();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
