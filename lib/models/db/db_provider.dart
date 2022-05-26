
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;
  DBProvider() {
    database;
  }

  Future<Database?> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = (documentsDirectory.path + "dbListaCompras.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE item ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "titulo TEXT,"
          "descricao TEXT,"
          "DataLimite TEXT"
          ")");
    });
  }

  
}
