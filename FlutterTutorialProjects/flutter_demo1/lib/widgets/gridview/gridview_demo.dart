import 'package:flutter/material.dart';
import 'service.dart';
import 'album.dart';
import 'cell.dart';
import 'dart:async';
import 'details.dart';

class GridViewDemo extends StatefulWidget {
  GridViewDemo() : super();

  final String title = "Photos Demo";

  @override
  GridViewDemoState createState() => GridViewDemoState();
}

class GridViewDemoState extends State<GridViewDemo> {
  //
  StreamController<int> streamController = new StreamController<int>();

  gridview(AsyncSnapshot<List<Album>> snapshot) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: snapshot.data.map(
          (album) {
            return GestureDetector(
              child: GridTile(
                child: AlbumCell(album),
              ),
              onTap: () {
                cellClick(context, album);
              },
            );
          },
        ).toList(),
      ),
    );
  }

  cellClick(BuildContext context, Album album) {
    print("Clicked ${album.title}");
    goToNextPage(context, album);
  }

  void goToNextPage(BuildContext context, Album curAlbum) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => GridDetails(
              curAlbum: curAlbum,
            ),
      ),
    );
  }

  static Center circularProgress() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightGreen),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          initialData: 0,
          stream: streamController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Text('${widget.title} [${snapshot.data}]');
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: FutureBuilder<List<Album>>(
              future: Services.getPhotos(),
              builder: (context, snapshot) {
                //
                if (snapshot.hasError) {
                  return Text("Error occured ${snapshot.error}");
                }
                //
                if (snapshot.hasData) {
                  streamController.sink.add(snapshot.data.length);
                  return gridview(snapshot);
                }
                //
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
