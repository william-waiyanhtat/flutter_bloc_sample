import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class AutoCompleteDemo extends StatefulWidget {
  AutoCompleteDemo() : super();

  final String title = "AutoComplete Demo";

  @override
  _AutoCompleteDemoState createState() => _AutoCompleteDemoState();
}

class _AutoCompleteDemoState extends State<AutoCompleteDemo> {
  static List<User> players;
  AutoCompleteTextField searchTextField;
  TextEditingController controller = new TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<User>> key = new GlobalKey();

  void callService() async {
    print("Calling Service...");

    try {
      final response =
          await http.get("https://jsonplaceholder.typicode.com/users");
      if (response.statusCode == 200) {
        await loadPlayers(response.body);
      } else {
        print("Error");
      }
    } catch (e) {}
  }

  static Future loadPlayers(String jsonString) async {
    try {
      List<User> players;
      players = new List<User>();
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson as List;
      for (int i = 0; i < categoryJson.length; i++) {
        players.add(new User.fromJson(categoryJson[i]));
      }
      print('Length {$players.length}');
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    callService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AutoCompleteTextField<User>(
            key: key,
            suggestions: players,
            style: new TextStyle(color: Colors.black, fontSize: 16.0),
            decoration: new InputDecoration(
                suffixIcon: Container(
                  width: 85.0,
                  height: 60.0,
                ),
                contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                filled: true,
                hintText: 'Search Name',
                hintStyle: TextStyle(color: Colors.black)),
            itemFilter: (item, query) {
              return item.name.toLowerCase().startsWith(query.toLowerCase());
            },
            itemSorter: (a, b) {
              return a.name.compareTo(b.name);
            },
            itemSubmitted: (item) {
              setState(
                  () => searchTextField.textField.controller.text = item.name);
            },
            itemBuilder: (context, item) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.name,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                  ),
                  Text(
                    item.email,
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
