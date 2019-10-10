import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Utility.dart';
import 'DBHelper.dart';
import 'Photo.dart';
import 'dart:async';

class SaveImageDemo extends StatefulWidget {
  SaveImageDemo() : super();

  final String title = "Flutter Save Image in DB";

  @override
  SaveImageDemoState createState() => SaveImageDemoState();
}

class SaveImageDemoState extends State<SaveImageDemo> {
  //
  Future<File> imageFile;
  Image image;
  DBHelper dbHelper;
  List<Photo> images;

  @override
  void initState() {
    super.initState();
    images = [];
    dbHelper = new DBHelper();
    refreshImages();
  }

  refreshImages() {
    dbHelper.getPhotos().then((val) {
      setState(() {
        images.clear();
        images.addAll(val);
      });
    });
  }

  pickImageFromGallery(ImageSource source) {
    ImagePicker.pickImage(source: source).then((imgFile) {
      print("Returned ${imgFile.path}");
      String imgString = Utility.base64String(
        imgFile.readAsBytesSync(),
      );
      Photo photo = Photo(0, imgString);
      dbHelper.save(photo);
      refreshImages();
    });
  }

  gridview() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: images.map(
          (photo) {
            return Utility.imageFromBase64String(photo.photo_name);
          },
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              pickImageFromGallery(ImageSource.gallery);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: gridview(),
            ),
          ],
        ),
      ),
    );
  }
}
