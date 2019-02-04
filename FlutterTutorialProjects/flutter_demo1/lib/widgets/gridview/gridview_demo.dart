import 'package:flutter/material.dart';
import 'service.dart';
import 'album.dart';
import 'cell.dart';
import 'dart:async';

class GridViewDemo extends StatefulWidget {
  GridViewDemo() : super();

  final String title = "Grid Demo";

  @override
  GridViewDemoState createState() => GridViewDemoState();
}

class GridViewDemoState extends State<GridViewDemo> {
  //
  StreamController<int> streamController = new StreamController<int>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          initialData: 0,
          stream: streamController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Text('${widget.title} ${snapshot.data}');
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
                  return error(snapshot);
                }
                //
                if (snapshot.hasData) {
                  streamController.sink.add(snapshot.data.length);
                  return gridview(snapshot);
                } else if (snapshot.hasError) {
                  return error(snapshot);
                } else {
                  return circularProgress();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

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
          (item) {
            return GestureDetector(
              child: GridTile(
                child: AlbumCell(
                  context,
                  item,
                ),
              ),
              onTap: () {
                rowClick(context, item);
              },
            );
          },
        ).toList(),
      ),
    );
  }

  error(AsyncSnapshot<List<Album>> snapshot) {
    return Text("Error occured ${snapshot.error}");
  }

  rowClick(BuildContext context, Album album) {
    print("Clicked ${album.title}");
  }

  static Center circularProgress() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightGreen),
      ),
    );
  }
}
