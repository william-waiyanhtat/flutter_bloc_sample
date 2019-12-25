import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'User.dart';
import 'Exceptions.dart';

class Services {
  static const String url = 'https://jsonplaceholder.typicode.com/users';

  static Future<List<User>> getUsers() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        List<User> users = parseUsers(response.body);
        return users;
        //throw Exception('Unknown Error');
      } else {
        return List<User>();
      }
    } on SocketException catch (e) {
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  static List<User> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}
