import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/user.dart';
import '../../models/users.dart';

class Services {
  static const String url = 'https://jsonplaceholder.typicode.com/users';

  static Future<Users> getUsers() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Users list = parseUsers(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Users parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<User> users = parsed.map<User>((json) => User.fromJson(json)).toList();
    Users u = Users();
    u.users = users;
    return u;
  }
}
