import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:intl/intl.dart';
import 'package:todo/services/databaseService.dart';

class ShowATask extends StatelessWidget {
  final VoidCallback deleteCallback;
  final Task task;
  final List<String> priorities = ['Important', 'Urgent', 'Critical'];
  ShowATask({@required this.task,this.deleteCallback});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10.0,
          child: ListTile(
            title: Text(task.title),
            trailing: IconButton(icon: Icon(Icons.delete), onPressed: ()async{
              DatabaseService databaseService=DatabaseService();
              await databaseService.deleteTask(task.id);
              deleteCallback();
            }),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text(DateFormat('d MMM y').format(DateTime.fromMillisecondsSinceEpoch(task.startDate))+" - "+DateFormat('d MMM y').format(DateTime.fromMillisecondsSinceEpoch(task.endDate))),
                Text(priorities[task.priority])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
