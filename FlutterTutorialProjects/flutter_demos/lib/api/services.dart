import 'dart:io';
import 'package:flutter_demos/models/albums_list.dart';
import 'package:flutter_demos/models/album_list_error.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'constants.dart';
import 'exceptiions.dart';

abstract class SpotifyRepo {
  Future<AlbumsList> getAlbumsList();
}

class SpotifyAlbumServices implements SpotifyRepo {
  //
  static const _baseUrl = 'api.spotify.com';
  static const String _GET_ALBUMS = '/v1/albums';

  @override
  Future<AlbumsList> getAlbumsList() async {
    Map<String, String> parameters = {
      'ids': ids,
      'market': 'ES',
    };
    Uri uri = Uri.https(_baseUrl, _GET_ALBUMS, parameters);
    Response response = await http.get(uri, headers: headers());
    try {
      if (response.statusCode == 200) {
        AlbumsList albumsList = albumsListFromJson(response.body);
        return albumsList;
      } else {
        SpotifyError spotifyError = spotifyErrorFromJson(response.body);
        throw SpotifyException(error: spotifyError);
      }
    } catch (e) {
      if (e is SpotifyException) {
        rethrow;
      }
      throw UnknownException('Unkown Error');
    }
  }

  static Map<String, String> headers() {
    return {
      'Accept': 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $AUTH_TOKEN',
    };
  }
}
