import 'package:flutter/material.dart';
import 'services.dart';
import 'gridcell.dart';
import 'DetailsScreen.dart';
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
  bool albumsLoaded;
  double percent;
  String title;
  GlobalKey<ScaffoldState> _scaffoldKey;

  static Albums albums;
  DBHelper dbHelper;

  @override
  void initState() {
    super.initState();
    percent = 0.0;
    title = widget.title;
    albumsLoaded = false;
    dbHelper = new DBHelper();
    _scaffoldKey = GlobalKey();
  }

  getPhotos() {
    setState(() {
      counter = 0;
      albumsLoaded = false;
    });
    Services.getPhotos().then((allAlbums) {
      albums = allAlbums;
      dbHelper.truncateTable().then((val) {
        insert(albums.albums[0], dbHelper);
      });
    });
  }

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
            return GridTile(
              child: AlbumCell(album, update, delete),
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

  update(Album album) {
    print("Updating  ${album.id}");
    dbHelper.update(album).then((updtVal) {
      showSnackBar("Updated Album ID:${album.id}");
      refresh();
    });
  }

  delete(int id) {
    print("Deleting  $id");
    dbHelper.delete(id).then((delVal) {
      print("Delted $delVal");
      showSnackBar("Deleted Album ID:$id");
      refresh();
    });
  }

  refresh() {
    dbHelper.getAlbums().then((allAlbums) {
      setState(() {
        albums = allAlbums;
        counter = albums.albums.length;
        title = '${widget.title} [$counter]';
      });
    });
  }

  insert(Album album, DBHelper dbHelper) {
    dbHelper.save(album).then(((val) {
      counter = counter + 1;
      percent = ((counter / albums.albums.length) * 100) / 100;
      if (counter >= albums.albums.length) {
        print("Done");
        setState(() {
          albumsLoaded = true;
          percent = 0.0;
          title = '${widget.title} [$counter]';
        });
        return;
      }
      setState(() {
        title = 'Inserting...$counter';
      });
      Album a = albums.albums[counter];
      insert(a, dbHelper);
    }));
  }

  showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              getPhotos();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          albumsLoaded
              ? Flexible(
                  child: FutureBuilder<Albums>(
                    future: dbHelper.getAlbums(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ${snapshot.error}');
                      }
                      if (snapshot.hasData) {
                        return gridview(snapshot);
                      }
                      return Container();
                    },
                  ),
                )
              : LinearProgressIndicator(
                  value: percent,
                ),
        ],
      ),
    );
  }
}
