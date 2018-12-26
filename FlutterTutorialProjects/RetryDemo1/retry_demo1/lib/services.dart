import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cell_model.dart';
import 'constants.dart';

class Services {
  static Future<List<CellModel>> fetchHomeData() async {
    final response = await http.get(APPURLS.SAMPLE_URL);
    try {
      if (response.statusCode == 200) {
        List<CellModel> list = parsePostsForHome(response.body);
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  static List<CellModel> parsePostsForHome(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CellModel>((json) => CellModel.fromJson(json)).toList();
  }
}
