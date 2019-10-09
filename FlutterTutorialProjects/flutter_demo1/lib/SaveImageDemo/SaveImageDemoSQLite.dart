import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Utility.dart';
import 'DBHelper.dart';
import 'Photo.dart';

class SaveImageDemo extends StatefulWidget {
  SaveImageDemo() : super();

  final String title = "Flutter Pick Image demo";

  @override
  _SaveImageDemoState createState() => _SaveImageDemoState();
}

class _SaveImageDemoState extends State<SaveImageDemo> {
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
    dbHelper.getPhotos().then((val) {
      images = val;
    });
  }

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
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
            return GridTile(
              child:
                  Text('sdsdsd'), // Utility.imageFromBase64String(photo.data),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget imageFromGallery() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          print(snapshot.data.path);
          String imgString = Utility.base64String(
            snapshot.data.readAsBytesSync(),
          );
          Photo photo = Photo(0, imgString);
          dbHelper.save(photo);
          // setState(() {
          //   images.add(photo);
          // });
          return Image.file(
            snapshot.data,
          );
          //return Container();
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            OutlineButton(
              child: Text("Select Image from Gallery"),
              onPressed: () {
                pickImageFromGallery(ImageSource.gallery);
                setState(() {
                  image = null;
                });
              },
            ),
            imageFromGallery(),
            SizedBox(
              height: 20.0,
            ),
            Flexible(
              child: gridview(),
            ),
          ],
        ),
      ),
    );
  }
}
