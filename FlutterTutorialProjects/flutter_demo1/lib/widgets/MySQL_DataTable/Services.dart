import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Employees.dart';

class Services {
  static const ROOT = 'http://localhost/Employees/employee_actions.php';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _CREATE_ACTION = 'CREATE_TABLE';
  static const String _ADD_EMP_ACTION = 'ADD_EMP';
  static const String _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const String _DELETE_EMP_ACTIOn = 'DELETE_EMP';

  static Future<List<Employee>> getEmployees() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      final response = await http.post(ROOT, body: map);
      print("getEmployees >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Employee> list = parsePhotos(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      return List<Employee>();
    }
  }

  static List<Employee> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  // static Future<bool> createTable() async {
  //   try {
  //     final response = await http.get(_create_table_url);
  //     print("createTable >> Response:: ${response.body}");
  //     return 'success' == response.body;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // static Future<bool> addEmployee(String firstName, String lastName) async {
  //   try {
  //     final response = await http.get(_create_table_url);
  //     print("addEmployee >> Response:: ${response.body}");
  //     return 'success' == response.body;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // static Future<bool> deleteEmployee(String empId) async {
  //   try {
  //     final response = await http.get(_delete_employee_url);
  //     print("deleteEmployee >> Response:: ${response.body}");
  //     return 'success' == response.body;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
