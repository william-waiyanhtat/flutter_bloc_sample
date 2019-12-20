import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'User.dart';
import 'Failures.dart';
import 'FailureCodes.dart';

class Services {
  static const String url = 'https://jsonplaceholder.typicode.com/users';

  // static Future<List<User>> getUsers() async {
  //   try {
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       List<User> list = parseUsers(response.body);
  //       // return list;
  //       throw SocketException('err');
  //     } else {
  //       throw Exception("Error");
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  static Future<List<User>> getUsers() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<User> list = parseUsers(response.body);
        //return list;
        throw SocketException('No Internet');
      } else {
        throw NoUsersFailure(0, "No Users.");
      }
    } on SocketException catch (e) {
      throw InternetFailureException(-1, "No Internet Connection.");
    } on HttpException {
      throw ServiceNotFoundException(-2, "Service Failure.");
    } on FormatException {
      throw InvalidDataFormatException(-3, "Invalid Data Format.");
    }
  }

  static List<User> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}
