import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sql.dart';

class DBhelper {
  static Future<sql.Database> databasess() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath, 'place.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY , title TEXT , image TEXT )');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBhelper.databasess();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getdata(String table) async {
    final db = await DBhelper.databasess();
    return db.query(table);
  }
}
