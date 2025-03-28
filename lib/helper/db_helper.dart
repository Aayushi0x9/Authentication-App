import 'package:authentication_app_exam/model/user_model.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();
  Logger logger = Logger();
  Database? db;
  String email = 'Email', psw = 'Password', userName = 'Name';
  String uid = 'uid';
  String tableName = 'User';

  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();

    String path = "$dbPath/user.db";
    db = await openDatabase(path, version: 1, onCreate: (db, _) async {
      String query = '''CREATE TABLE $tableName(
         $uid INTEGER PRIMARY KEY AUTOINCREMENT,
        $userName  TEXT NOT NULL,
        $email TEXT NOT NULL,
         $psw INT NOT NULL
      );
      ''';
      db.execute(query).then(
        (value) {
          logger.i('Succesfully create table');
        },
      ).onError(
        (error, _) {
          logger.e('table not created');
        },
      );
    });
  }

  Future<int?> insertUser({required UserModel model}) async {
    await initDB();
    String insertQuery =
        "INSERT INTO $tableName ($userName,$email,$psw) VALUES(?,?,?);";
    List arg = [model.name, model.email, model.password];
    return await db?.rawInsert(insertQuery, arg);
  }

  Future<List<UserModel>> fetchUser() async {
    await initDB();
    String fetchQuery = "SELECT * FROM $tableName;";

    List<Map<String, dynamic>>? res = await db?.rawQuery(fetchQuery);
    return res!.map((e) => UserModel.fromMap(data: e)).toList();
  }

  Future<int?> updateUser({required UserModel model}) async {
    await initDB();

    String updateQuery =
        "UPDATE $tableName SET $userName = ?,$email=?,$psw = ? WHERE $uid = ${model.id}";
    List arg = [model.name, model.email, model.password];
    return await db?.rawUpdate(updateQuery, arg);
  }

  Future<int?> deleteUser({required int id}) async {
    await initDB();
    String deleteQuery = "DELETE FROM $tableName WHERE $uid = $id";
    return await db?.rawUpdate(deleteQuery);
  }
}
