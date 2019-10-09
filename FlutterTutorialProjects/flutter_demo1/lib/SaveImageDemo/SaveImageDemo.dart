import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Utility.dart';

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

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  loadImageFromPreferences() {
    Utility.getImageFromPreferences().then((img) {
      if (null == img) {
        return;
      }
      setState(() {
        image = Utility.imageFromBase64String(img);
      });
    });
  }

  Widget imageFromGallery() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          //print(snapshot.data.path);
          Utility.saveImageToPreferences(
              Utility.base64String(snapshot.data.readAsBytesSync()));
          return Image.file(
            snapshot.data,
          );
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
            SizedBox(
              height: 20.0,
            ),
            imageFromGallery(),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              child: Text('Load Image from Storage'),
              onPressed: () {
                loadImageFromPreferences();
              },
            ),
            null == image ? Container() : image,
          ],
        ),
      ),
    );
  }
}
