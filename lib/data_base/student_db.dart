import 'package:local_data_base/data_base/database_provider.dart';
import 'package:local_data_base/models/student_model_class.dart';
import 'package:sqflite/sqlite_api.dart';

class StudentDb {
  static const tableName = 'student';
  static const rollNoColumn = 'rollNo';
  static const nameColumn = 'name';
  static const feeColumn = 'fee';
  static const createTable =
      'CREATE TABLE IF NOT EXISTS $tableName($rollNoColumn INTEGER AUTO INCREMENT ,$nameColumn TEXT ,$feeColumn REAL )';
  static const dropTable = 'DROP TABLE $tableName IF EXISTS';

  Future<bool> insertStudent(StudentModelClass studentModelClass) async {
    Database database = await DBProvider.dataBase;
    var rowId = await database.insert(tableName, studentModelClass.toMap());
    return rowId > 0;
  }

  Future<bool> upDateStudent(StudentModelClass studentModelClass) async {
    Database database = await DBProvider.dataBase;
    var rowId = await database.update(
      tableName,
      studentModelClass.toMap(),
      where: '${StudentDb.rollNoColumn}=?',
      whereArgs: [studentModelClass.rollNo],
    );
    return rowId > 0;
  }

  Future<bool> deleteStudent(StudentModelClass studentModelClass) async {
    Database database = await DBProvider.dataBase;
    var rowId = await database.delete(tableName,
        where: '${StudentDb.rollNoColumn}=?',
        whereArgs: [studentModelClass.rollNo]);
    return rowId > 0;
  }

  Future<List<StudentModelClass>> fetchData() async {
    Database database = await DBProvider.dataBase;
    var listMap = await database.query(tableName);
    return listMap.map((map) => StudentModelClass.fromMap(map)).toList();
  }
}
