
class Task{
  int id,priority;
  String title;
  int startDate,endDate;
  List<String> subtasks;

  Task({this.id,this.title,this.priority,this.startDate,this.endDate,this.subtasks});
  
  Map<String,dynamic> toMap(){
    Map<String,dynamic> _ret={
      'title':title,
      'priority':priority,
      'startDate':startDate,
      'endDate':endDate,
    };
    String _combineSubTasks="";
    subtasks.forEach((element) {
      _combineSubTasks+=element+"|||";
     });
    _ret['subtasks']=_combineSubTasks;
    if(id!=null){
      _ret['id']=id;
    }
    return _ret;
  } 

  Task.fromMap(Map<String,dynamic> record){
    Task(
      id: record['id'] as int ?? 0,
      title: record['title'] as String ?? '',
      priority: record['priority'] as int ?? 0,
      startDate: record['startDate'] as int ?? DateTime.now().millisecondsSinceEpoch,
      endDate: record['endDate'] as int ?? DateTime.now().millisecondsSinceEpoch,
      subtasks: (record['subtasks'] as String ?? '').split('|||'),
    );
  }
}