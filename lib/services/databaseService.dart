import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';
import 'dart:async';

class DatabaseService {
  static String _dbName = 'database.db';
  static String _tasksTable = 'tasks';
  static String _subtasksTable = 'subtasks';
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);
    await deleteDatabase(path);
    return await openDatabase(path, version: 1,
        onCreate: (Database _db, int version) async {
      await _db.execute(
        "CREATE TABLE $_tasksTable(id INTEGER PRIMARY KEY, title TEXT, priority INTEGER,startDate INTEGER,endDate INTEGER,subtasks TEXT)",
      );
      await _db.execute(
        "CREATE TABLE $_subtasksTable(id INTEGER PRIMARY KEY, title TEXT, priority INTEGER,startDate INTEGER,endDate INTEGER,subtasks TEXT)",
      );
      print("Database Created");
      return;
    });
  }

  Future<int> saveTask(Task _task) async {
    _db = await db;
    int _insertedId = await _db.insert(_tasksTable, _task.toMap());
    return _insertedId;
  }

  Future<List<Task>> getAllTasks() async {
    _db = await db;
    List<Map<String, dynamic>> _allTasks = await _db.query(_tasksTable);
    List<Task> _ret = new List();
    _allTasks.forEach((element) {
      _ret.add(Task.fromMap(element));
    });
    print("From getAllTasks() -> " + _ret.toString());
    return _ret;
  }

  Future<Task> getTask(int idx) async {
    _db = await db;
    List<Map<String, dynamic>> _queryResult =
        await _db.query(_tasksTable, where: "id=$idx");
    if (_queryResult.length > 0) {
      return Task.fromMap(_queryResult[0]);
    } else {
      return null;
    }
  }

  Future<Task> getSubTask(int idx) async {
    _db = await db;
    List<Map<String, dynamic>> _queryResult =
        await _db.query(_subtasksTable, where: "id=$idx");
    if (_queryResult.length > 0) {
      return Task.fromMap(_queryResult[0]);
    } else {
      return null;
    }
  }

  Future deleteTask(int idx) async {
    _db = await db;
    Task _toBeDeleted = await getTask(idx);
    List<int> _subtaskIds = _toBeDeleted.subtasks;
    _db.delete(_subtasksTable, where: "id IN (${_subtaskIds.join(', ')})");
    await _db.delete(_tasksTable, where: "id=$idx");
  }

  Future<int> saveSubTask(Task _subtask) async {
    _db = await db;
    int _insertedId = await _db.insert(_subtasksTable, _subtask.toMap());
    return _insertedId;
  }

  Future<List<Task>> getAllSubTasks(List<int> idx) async {
    _db = await db;
    List<Map<String, dynamic>> _allSubTasks =
        await _db.query(_subtasksTable, where: "id IN (${idx.join(', ')})");
    List<Task> _ret = new List();
    _allSubTasks.forEach((element) {
      _ret.add(Task.fromMap(element));
    });
    // print(_ret);
    return _ret;
  }
}
