import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class UploadDemo extends StatefulWidget {
  UploadDemo() : super();

  final String title = "Upload Demo";

  @override
  UploadDemoState createState() => UploadDemoState();
}

class UploadDemoState extends State<UploadDemo> {
  // uploadFile(File imageFile) async {
  //   var stream =
  //       new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //   var length = await imageFile.length();

  //   var uri = Uri.parse(uploadURL);

  //   var request = new http.MultipartRequest("POST", uri);
  //   var multipartFile = new http.MultipartFile('file', stream, length,
  //       filename: basename(imageFile.path));
  //   //contentType: new MediaType('image', 'png'));

  //   request.files.add(multipartFile);
  //   var response = await request.send();
  //   print(response.statusCode);
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     print(value);
  //   });
  // }

  File _image;

Future cameraImage() async {
  var image = await ImagePicker.pickImage(
    source: ImageSource.camera,
    maxHeight: 240.0,
    maxWidth: 240.0,
  );

  setState(() {
    _image = image;
  });
}

submitForm() async {
  final response = await http.post(
    uri,
    headers: {
      AuthUtils.AUTH_HEADER: _authToken
    },
    body: {
      'user_id': userId
      'photo': _image != null ? 'data:image/png;base64,' +
          base64Encode(_image.readAsBytesSync()) : '',
    },
  );

  final responseJson = json.decode(response.body);

  print(responseJson);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[],
      ),
    );
  }
}
