
class Task{
  int id,priority;
  String title;
  int startDate,endDate;
  List<int> subtasks;
  
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
      _combineSubTasks+=element.toString()+"|||";
     });
    _ret['subtasks']=_combineSubTasks;
    if(id!=null){
      _ret['id']=id;
    }
    return _ret;
  } 

  Task.fromMap(Map<String,dynamic> record){
      id= record['id'] as int ?? 0;
      title= record['title'] as String ?? '';
      priority= record['priority'] as int ?? 0;
      startDate= record['startDate'] as int ?? DateTime.now().millisecondsSinceEpoch;
      endDate= record['endDate'] as int ?? DateTime.now().millisecondsSinceEpoch;
      String _temp=record['subtasks'];
      // print(_temp);
      // print(_temp.substring(0,_temp.length-3).split('|||'));
      if(_temp.length>0){
        _temp=_temp.substring(0,_temp.length-3);
        subtasks= _temp.split('|||').map((e) => int.parse(e)).toList();
      }else{
        subtasks=new List<int>();
      }
  }
}