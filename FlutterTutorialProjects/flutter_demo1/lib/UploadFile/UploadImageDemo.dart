import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadImageDemo extends StatefulWidget {
  UploadImageDemo() : super();

  final String title = "Bottom Navigation Demo";

  @override
  UploadImageDemoState createState() => UploadImageDemoState();
}

class UploadImageDemoState extends State<UploadImageDemo> {
  final String phpEndPoint = 'http://localhost/flutter_test/upload_image.php';
  Future<File> file;
  String base64Image;
  AsyncSnapshot<File> tmpFile;

  void _choose() {
    setState(() {
      //    file = await ImagePicker.pickImage(source: ImageSource.camera);
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  void _upload() {
    if (tmpFile == null) {
      return;
    }
    String fileName = tmpFile.data.path.split("/").last;

    http.post(phpEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.body);
    }).catchError((err) {
      print(err);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          tmpFile = snapshot;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
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

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            onPressed: _choose,
            child: Text('Choose Image'),
          ),
          showImage(),
          SizedBox(width: 10.0),
          RaisedButton(
            onPressed: _upload,
            child: Text('Upload Image'),
          )
        ],
      ),
    );
  }
}
