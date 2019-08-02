import 'dart:convert';
import 'db_helper.dart';
import 'package:http/http.dart' as http;
import '../../models/album.dart';
import '../../models/albums.dart';

class Services {
  //
  static List<Album> albums;
  static int counter = 0;
  static const String url = "https://jsonplaceholder.typicode.com/photos";

  static Future<Albums> getPhotos() async {
    counter = 0;
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("success");
        Albums albums = parsePhotos(response.body);
        return albums;
      } else {
        print("exce1");
      }
    } catch (e) {
      print("exce");
      return new Albums();
    }
  }

  static Albums parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Album> albums =
        parsed.map<Album>((json) => Album.fromJson(json)).toList();
    Albums a = new Albums();
    a.albums = albums;
    return a;
  }
}
