import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/album.dart';
import '../../models/albums.dart';

class DBHelper {
  static Database _db;
  static const String TABLE = 'albums';
  static const String ALBUM_ID = 'album_id';
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String URL = 'url';
  static const String THUMBNAIL_URL = 'thumbnail_url';
  static const String DB_NAME = 'albums.db';

  Future<Database> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $TITLE TEXT, $URL TEXT, $THUMBNAIL_URL TEXT)");
  }

  Future<Album> save(Album album) async {
    var dbClient = await db;
    album.id = await dbClient.insert(TABLE, album.toJson());
    return album;
  }

  Future<Albums> getEmployees() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, TITLE]);
    Albums allAlbums = Albums();
    List<Album> albums = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        albums.add(Album.fromJson(maps[i]));
      }
    }
    allAlbums.albums = albums;
    return allAlbums;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Album employee) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, employee.toJson(),
        where: '$ID = ?', whereArgs: [employee.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
