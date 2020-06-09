import 'package:flutter/material.dart';
import 'package:todo/screens/home/showTasks.dart';
import 'package:todo/screens/input/addTask.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/databaseService.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Todo"),
      ),
      bottomNavigationBar: SizedBox(
        height: 60.0,
        child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.menu), onPressed: null),
                IconButton(icon: Icon(Icons.more_vert), onPressed: null)
              ],
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
          child: FloatingActionButton(
        onPressed: () async{
          _saveTodo(context);
        },
        child: Icon(Icons.add),
      )),
      body: ShowTasks(),
    );
  }

  void _saveTodo(BuildContext context) async {
    Task _task =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddTask();
    }));
    if(_task==null){
      print("Task is NULL");
      return;
    }
    DatabaseService _databaseService = DatabaseService();
    await _databaseService.saveTask(_task);
    print("Saved");
    setState(() {
      
    });
  }
}
