import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'employee.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String FIRST_NAME = 'firstname';
  static const String LAST_NAME = 'lastname';
  static const String TABLE = 'Employee';
  static const String DB_NAME = "employee6.db";

  Future<Database> get db async {
    if (_db != null) {
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

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY, $FIRST_NAME TEXT, $LAST_NAME TEXT)");
    print("Created tables");
  }

  // Retrieving employees from Employee Tables
  Future<List<Employee>> getEmployees() async {
    var dbClient = await db;
    List<Map> maps =
        await dbClient.query(TABLE, columns: [ID, FIRST_NAME, LAST_NAME]);
    // List<Map> list = await dbClient.rawQuery('SELECT * FROM Employee');
    List<Employee> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(Employee.fromMap(maps[i]));
      }
    }
    return employees;
  }

  Future<Employee> save(Employee employee) async {
    var dbClient = await db;
    employee.id = await dbClient.insert(TABLE, employee.toMap());
    return employee;
    // await dbClient.transaction((txn) async {
    //   var query = "INSERT INTO Employee (firstname, lastname) VALUES ('" +
    //       firstName +
    //       "', '" +
    //       lastName +
    //       "')";
    //   print("Query : " + query);
    //return await txn.rawInsert(query);
    //});
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Employee employee) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, employee.toMap(),
        where: '$ID = ?', whereArgs: [employee.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
