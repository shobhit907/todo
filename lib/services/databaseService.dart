import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';
import 'dart:async';

class DatabaseService {
  static String _dbName = 'database.db';
  static String _tableName = 'tasks';
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    return await openDatabase(join(await getDatabasesPath(), _dbName),
        version: 1, onCreate: (Database _db, int version) {
      return _db.execute(
        "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT, priority INTEGER,startDate INTEGER,endDate INTEGER,subtasks TEXT)",
      );
    });
  }

  Future saveTask(Task _task)async{
    Database _db=await db;
    return await _db.insert(_tableName, _task.toMap());
  }

  Future<List<Task>> getAllTasks()async{
    Database _db=await db;
    List<Map<String,dynamic>> _allTasks=await _db.query(_tableName);
    List<Task> _ret=new List();
    _allTasks.forEach((element) {
      _ret.add(Task.fromMap(element));
    });
    print(_ret);
    return _ret;
  }

}
