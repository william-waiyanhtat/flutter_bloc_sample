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
  int numPhotos;

  @override
  void initState() {
    super.initState();
    numPhotos = 0;
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
            child: Container(
              child: FutureBuilder<List<Album>>(
                future: Services.getPhotos(),
                builder: (context, snapshot) {
                  //
                  if (snapshot.hasError) {
                    return Text("Error occured");
                  }
                  //
                  if (snapshot.hasData) {
                    numPhotos = snapshot.data.length;
                    streamController.sink.add(numPhotos);
                    print(numPhotos);
                    return new Padding(
                      padding: new EdgeInsets.all(5.0),
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
                  } else if (snapshot.hasError) {
                    return Text("Error 2");
                  } else {
                    return circularProgress();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  rowClick(BuildContext context, Album album) {
    //
    print("Clicked ${album.title}");
  }

  static Center circularProgress() {
    return Center(
        child: CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightGreen),
    ));
  }
}
