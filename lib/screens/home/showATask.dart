import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:intl/intl.dart';

class ShowATask extends StatelessWidget {
  final Task task;
  final List<String> priorities = ['Important', 'Urgent', 'Critical'];
  ShowATask({@required this.task});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10.0,
          child: ListTile(
            title: Text(task.title),
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
