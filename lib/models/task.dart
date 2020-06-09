import 'package:flutter/foundation.dart';

class Task{
  int id,priority;
  String title;
  int startDate,endDate;
  List<String> subtasks;

  Task({this.id,this.title,this.priority,this.startDate,this.endDate,this.subtasks});
  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'title':title,
      'priority':priority,
      'startDate':startDate,
      'endDate':endDate,
      'subtasks':subtasks,
    };
  }

  Task.fromMap(Map<String,dynamic> record){
    Task(
      id: record['id'] as int ?? 0,
      title: record['title'] as String ?? '',
      priority: record['priority'] as int ?? 0,
      startDate: record['startDate'] as int ?? DateTime.now().millisecondsSinceEpoch,
      endDate: record['endDate'] as int ?? DateTime.now().millisecondsSinceEpoch,
      subtasks: record['subtasks'] as List<String>,
    );
  }
}