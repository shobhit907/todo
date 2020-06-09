import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/home/showATask.dart';
import 'package:todo/screens/loading.dart';
import 'package:todo/services/databaseService.dart';

class ShowTasks extends StatefulWidget {
  @override
  _ShowTasksState createState() => _ShowTasksState();
}

class _ShowTasksState extends State<ShowTasks> {
  DatabaseService _databaseService=DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(future: _databaseService.getAllTasks(),builder: (BuildContext context,AsyncSnapshot<List<Task>>_snapshot){
        if(_snapshot.hasData){
          _snapshot.data.sort((task1,task2){return task2.priority-task1.priority;});
          return ListView.builder(itemCount: _snapshot.data.length,itemBuilder: (BuildContext context,int index){
            return ShowATask(task: _snapshot.data[index]);
          });
        }else{
          return Center(child: Loading());
        }
      }),
    );
  }
}