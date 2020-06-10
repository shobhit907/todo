import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:intl/intl.dart';
import 'package:todo/services/databaseService.dart';

class ShowATask extends StatelessWidget {
  final VoidCallback deleteCallback;
  final Task task;
  final List<String> priorities = ['Important', 'Urgent', 'Critical'];
  static DatabaseService _databaseService = DatabaseService();
  ShowATask({@required this.task, this.deleteCallback});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10.0,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(task.title),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      DatabaseService databaseService = DatabaseService();
                      await databaseService.deleteTask(task.id);
                      deleteCallback();
                    }),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat('d MMM y').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                task.startDate)) +
                        " - " +
                        DateFormat('d MMM y').format(
                            DateTime.fromMillisecondsSinceEpoch(task.endDate))),
                    Text(priorities[task.priority])
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: FutureBuilder(
                    future: _databaseService.getAllSubTasks(task.subtasks),
                    builder: (context, AsyncSnapshot<List<Task>> _snapshot) {
                      if (_snapshot.hasData) {
                        return Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _snapshot.data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(_snapshot.data[index].title),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(DateFormat('d MMM y').format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  _snapshot
                                                      .data[index].startDate)) +
                                          " - " +
                                          DateFormat('d MMM y').format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  _snapshot
                                                      .data[index].endDate))),
                                      Text(priorities[
                                          _snapshot.data[index].priority])
                                    ],
                                  ),
                                );
                              }),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
