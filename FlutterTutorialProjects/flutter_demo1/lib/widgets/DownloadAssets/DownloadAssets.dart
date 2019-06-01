import 'package:flutter/material.dart';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class DownloadAssetsDemo extends StatefulWidget {
  DownloadAssetsDemo() : super();

  final String title = "Download Assets Demo";

  @override
  DownloadAssetsDemoState createState() => DownloadAssetsDemoState();
}

class DownloadAssetsDemoState extends State<DownloadAssetsDemo> {
  //
  String _dir;
  List<String> _images, _tempImages;
  String _status = "Download assetsr";
  String zipPath = 'http://coderzheaven.com/youtube_flutter/images.zip';
  String localZipFileName = 'images.zip';

  Future<void> _downloadAssets() async {
    setState(() {
      _status = 'Downloading assets...';
    });

    _images.clear();
    _tempImages.clear();

    var zippedFile = await _downloadFile(zipPath, localZipFileName);

    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);

    for (var file in archive) {
      var filename = '$_dir/${file.name}';
      if (file.isFile) {
        var outFile = File(filename);
        print("file " + outFile.path);
        _tempImages.add(outFile.path);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }

    setState(() {
      _images.addAll(_tempImages);
      _status = 'Download Success';
    });
  }

  Future<File> _downloadFile(String url, String filename) async {
    var req = await http.Client().get(Uri.parse(url));
    var file = File('$_dir/$filename');
    return file.writeAsBytes(req.bodyBytes);
  }

  @override
  void initState() {
    super.initState();
    _images = List();
    _tempImages = List();
    initDir();
  }

  initDir() async {
    if (null == _dir) {
      _dir = (await getApplicationDocumentsDirectory()).path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_status),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              _downloadAssets();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _images.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(
                    File(_images[index]),
                    fit: BoxFit.fitWidth,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
