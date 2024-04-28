import 'package:local_data_base/data_base/student_db.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;

  static Future<Database> get dataBase async {
    var dataBasePath = await getDatabasesPath();
    return _database ??= await openDatabase(
      'path:${dataBasePath.toString()}',
      onCreate: (db, version) {
        db.execute(StudentDb.createTable);
      },
      version: 1,
    );
  }
}
