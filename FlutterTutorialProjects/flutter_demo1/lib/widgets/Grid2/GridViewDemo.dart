import 'package:flutter/material.dart';
import 'services.dart';
import 'gridcell.dart';
import 'DetailsScreen.dart';
import 'dart:async';
import '../../models/album.dart';
import '../../models/albums.dart';
import 'db_helper.dart';

class GridViewDemo extends StatefulWidget {
  GridViewDemo() : super();

  final String title = "Photos";

  @override
  GridViewDemoState createState() => GridViewDemoState();
}

class GridViewDemoState extends State<GridViewDemo> {
  //
  int counter = 0;
  static List<Album> albums;

  @override
  void initState() {
    super.initState();
  }

  StreamController<int> streamController = new StreamController<int>();

  gridview(AsyncSnapshot<Albums> snapshot) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: snapshot.data.albums.map(
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
    );
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

  insert(Album album, DBHelper dbHelper) {
    dbHelper.save(album).then(((val) {
      print("111");
      counter = counter + 1;
      if (counter >= albums.length) {
        print("Done");
        dbHelper.getAlbums().then((albums1) {
          print("Count: ${albums1.albums.length}");
        });
        return;
      }
      setState(() {
        counter = counter;
      });
      Album a = albums[counter];
      insert(a, dbHelper);
    }));
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
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          OutlineButton(
            child: Text('Get Photos'),
            onPressed: () {
              counter = 0;
              Services.getPhotos().then((allAlbums) {
                albums = allAlbums.albums;
                DBHelper dbHelper = new DBHelper();
                insert(albums[0], dbHelper);
              });
            },
          ),
          Text("Inserted $counter"),
          // Flexible(
          //   child: FutureBuilder<Albums>(
          //     future: Services.getPhotos(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasError) {
          //         return Text('Error ${snapshot.error}');
          //       }
          //       if (snapshot.hasData) {
          //         streamController.sink.add(snapshot.data.albums.length);
          //         return gridview(snapshot);
          //       }
          //       return circularProgress();
          //     },
          //   ),
          // ),
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
