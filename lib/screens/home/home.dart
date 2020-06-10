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
  List<String> popUpOptions = [
    "Default",
    "Priority Low to High",
    "Priority High to Low"
  ];
  final _sortNotifier = ValueNotifier<int>(0);
  DatabaseService _databaseService = DatabaseService();
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
                PopupMenuButton(
                    tooltip: "Sort by Priority",
                    onSelected: (value) =>
                        _sortNotifier.value = popUpOptions.indexOf(value),
                    itemBuilder: (context) {
                      return popUpOptions
                          .map((e) => PopupMenuItem(child: Text(e), value: e))
                          .toList();
                    }),
              ],
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
          child: FloatingActionButton(
        onPressed: () async {
          _saveTodo(context);
        },
        tooltip: "Add Todo",
        child: Icon(Icons.add),
      )),
      body: ValueListenableBuilder(
          valueListenable: _sortNotifier,
          builder: (context, value, _) {
            return ShowTasks(
              ordering: value,
            );
          }),
    );
  }

  void _saveTodo(BuildContext context) async {
    Task _task =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddTask();
    }));
    if (_task == null) {
      // print("Task is NULL");
      return;
    }
    // print("Saving task...");
    int idOfTask=await _databaseService.saveTask(_task);
    // print("Saved");
    // print("ID is :"+idOfTask.toString());
    // print(_task.title.toString());
    setState(() {});
  }
}
