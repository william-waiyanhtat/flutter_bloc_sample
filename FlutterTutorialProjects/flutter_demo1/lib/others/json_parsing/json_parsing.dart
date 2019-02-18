import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'models.dart';
import 'services.dart';

class JSONDemo extends StatefulWidget {
  JSONDemo() : super();

  final String title = "JSON Demo";

  @override
  _JSONDemoState createState() => _JSONDemoState();
}

class _JSONDemoState extends State<JSONDemo> {
  //

  Future<String> loadPersonfromAssets() async {
    return await rootBundle.loadString('json/person.json');
  }

  Future loadPerson() async {
    String jsonString = await loadPersonfromAssets();
    final jsonResponse = json.decode(jsonString);
    Person person = new Person.fromJson(jsonResponse);
    print('Name ${person.name}');
    print('Places ${person.places}');
    print('House No ${person.address.details.houseNo}');
    print('Name ${person.images[0].name}');

    print("Loading Albums...");
    Services.getPhotos().then((albums) {
      print("Loaded Albums ${albums.length}");
    });
  }

  @override
  void initState() {
    super.initState();
    loadPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
