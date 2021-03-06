import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/input/addSubTask.dart';
import 'package:todo/services/databaseService.dart';

class AddTask extends StatefulWidget {
  Task editableTask;
  bool newTask;
  AddTask({this.newTask: false, this.editableTask});
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController _titleController = TextEditingController();
  List<DateTime> _dateRange = [null, null];
  List<String> priorities = ['Important', 'Urgent', 'Critical'];
  int _priorityValue = 0;
  List<int> _subTaskIds = [];
  final noOfSubtasks = ValueNotifier<int>(0);
  DatabaseService _databaseService = DatabaseService();
  // _AddTaskState() {
  //   // _titleController.value=TextEditingValue(text:"1");
  //   if (widget.newTask && widget.editableTask != null) {
  //     _titleController.value =
  //         TextEditingValue(text: widget.editableTask.title);
  //     _dateRange[0] =
  //         DateTime.fromMillisecondsSinceEpoch(widget.editableTask.startDate);
  //     _dateRange[1] =
  //         DateTime.fromMillisecondsSinceEpoch(widget.editableTask.endDate);
  //     _subtasks.value =
  //         TextEditingValue(text: widget.editableTask.subtasks.join());
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Todo"),
      ),
      body: Scrollbar(
          child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: FlatButton.icon(
                onPressed: () async {
                  _saveTodo();
                },
                icon: Icon(Icons.save),
                label: Text("Save Task")),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Container(
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Todo Title*",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Container(
              width: double.infinity,
              child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Add Priority",
                  ),
                  value: priorities[_priorityValue],
                  items: priorities
                      .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      _priorityValue = priorities.indexOf(newValue);
                    });
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                child: Container(
                  child: datePickerWidget(
                    context,
                    0,
                    "Start Date*",
                  ),
                  constraints: BoxConstraints(maxWidth: 150.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                child: Container(
                  child: datePickerWidget(
                    context,
                    1,
                    "End Date*",
                  ),
                  constraints: BoxConstraints(maxWidth: 150.0),
                ),
              )
            ],
          ),
          Container(
            child: RaisedButton.icon(
                onPressed: () async {
                  await addSubTodo();
                },
                icon: Icon(Icons.done_all),
                label: Text("Add Subtasks")),
          ),
          ValueListenableBuilder(
              valueListenable: noOfSubtasks,
              builder: (context, value, _) {
                return Container(
                    child: Container(
                  child: Text(value.toString() + " subtodo(s) added"),
                ));
              }),
        ],
      )),
    );
  }

  Future addSubTodo() async {
    int _idSubtaskAdded =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddSubTask();
    }));
    if (_idSubtaskAdded == null) {
      print("Subtask added is null");
      return;
    }
    print("Id of subtask from task add page : " + _idSubtaskAdded.toString());
    _subTaskIds.add(_idSubtaskAdded);
    noOfSubtasks.value = _subTaskIds.length;
  }

  Future _saveTodo() async {
    if (_titleController.value.text.isEmpty ||
        _dateRange[0] == null ||
        _dateRange[1] == null) {
      print("Fill mandatory values");
      return;
    }
    Task _task = Task(
        title: _titleController.value.text,
        priority: _priorityValue,
        startDate: _dateRange[0].millisecondsSinceEpoch,
        endDate: _dateRange[1].millisecondsSinceEpoch,
        subtasks: _subTaskIds);
    return Navigator.pop(context, _task);
  }

  final format = DateFormat("dd-MM-yyyy");

  Widget datePickerWidget(BuildContext context, int idx, String fieldName) {
    return Container(
      child: DateTimeField(
          decoration: InputDecoration(
            labelText: fieldName,
          ),
          autovalidate: true,
          format: format,
          onShowPicker: (context, newValue) async {
            var _selectedDate = await showDatePicker(
                context: context,
                initialDate: newValue ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            print(_selectedDate);
            _dateRange[idx] = _selectedDate;
            return _selectedDate;
          }),
    );
  }
}
