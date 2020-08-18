import 'dart:io';

import 'package:flutter_demos/model/account_model.dart';
import 'package:flutter_demos/model/video_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Services {
  //
  static const API_KEY = 'AIzaSyAhV9ZfNPWiDuuDSg3poGcWWMN6MQk1LaM';
  static const CHANNEL_ID = 'UC5lbdURzjB0irr-FTbjWN1A';
  static final String _baseUrl = 'www.googleapis.com';

  static Future<AccountModel> getAccountInfo() async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': CHANNEL_ID,
      'key': API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Response response = await http.get(
      uri,
      headers: headers,
    );
    print(response.body);
    AccountModel accountModel = accountModelFromJson(response.body);
    return accountModel;
  }

  static Future<VideosList> getVideosList(
      {String playlistId, String pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': pageToken,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    print(response.body);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }
}
