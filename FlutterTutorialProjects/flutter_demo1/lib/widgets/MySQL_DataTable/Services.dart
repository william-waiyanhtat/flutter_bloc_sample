import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Employees.dart';

class Services {
  static const String url = "http://localhost/Employees/get_employees.php";

  static Future<List<Employee>> getEmployees() async {
    try {
      final response = await http.get(url);
      print("Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      //throw Exception(e.toString());
      print("Error ${e.toString()}");
      return List<Employee>();
    }
  }

  static List<Employee> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }
}
