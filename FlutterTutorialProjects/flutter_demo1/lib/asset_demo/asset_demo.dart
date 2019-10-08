import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class PickImageDemo extends StatefulWidget {
  PickImageDemo() : super();

  final String title = "Flutter Pick Image demo";

  @override
  _PickImageDemoState createState() => _PickImageDemoState();
}

class _PickImageDemoState extends State<PickImageDemo> {
  Future<File> imageFile;
  Image image;
  static const String KEY = "IMAGE_KEY";

  Future<String> getImageFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY) ?? null;
  }

  Future<bool> saveImageToPreferences(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KEY, value);
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          //print(snapshot.data.path);
          saveImageToPreferences(base64Encode(snapshot.data.readAsBytesSync()));
          return Image.file(
            snapshot.data,
          );
        } else if (snapshot.error != null) {
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
            RaisedButton(
              child: Text("Select Image from Gallery"),
              onPressed: () {
                pickImageFromGallery(ImageSource.gallery);
                setState(() {
                  image = null;
                });
              },
            ),
            showImage(),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              child: Text('Load Image from Storage'),
              onPressed: () {
                getImageFromPreferences().then((img) {
                  // print(img);
                  if (null == img) {
                    return;
                  }
                  setState(() {
                    image = imageFromBase64String(img);
                  });
                });
              },
            ),
            null == image ? Container() : image,
          ],
        ),
      ),
    );
  }
}
