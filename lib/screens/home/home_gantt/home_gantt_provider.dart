import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/task/sub_task.dart';
import '../../../models/task/task.dart';
import '../../../services/db_manager.dart';

class Home_ganttProvider extends ChangeNotifier {

  List<Task> taskList = [];

  Set<SubTask> subTaskList = {};

  List<String> dateList = [];

  Future<void> init() async {

    taskList.addAll((await DbManager.instance.getTasks())!);
    addAllToSubTaskList();
    notifyListeners();
  }

  addAllToSubTaskList(){
    subTaskList.clear();
    for (var task in taskList) {
      subTaskList.addAll(task.subTask);
    }
    dateList = _getDateList();
  }


  List<SubTask> getList(){
    List<SubTask> list = subTaskList.toList();
    list.sort((a, b) => a.deadline!.compareTo(b.deadline!));
    return list;
  }


  _getDateList(){

    print("Home_ganttProvider ::: getDateList " + subTaskList.length.toString());

    List<DateTime?> list = subTaskList.map((e) => e.deadline).toSet().toList();

    List<String> dateList = [];
    DateFormat formatter = DateFormat('MMM dd');

    for (var date in list) {
      dateList.add(formatter.format(date!));
    }

    dateList.sort((a, b) => a.compareTo(b));

    print("Home_ganttProvider ::: getDateList " + dateList.toString());

    return dateList;

  }

  List<SubTask> getListFor(int index) {
    List<SubTask> list = getList();
    List<SubTask> subList = [];
    for (var subTask in list) {
      if(DateFormat('MMM dd').format(subTask.deadline!) == dateList[index]){
        subList.add(subTask);
      }
    }
    return subList;
  }

  String getTaskTitle(String taskId){
    for (var task in taskList) {
      if(task.id == taskId){
        return task.title;
      }
    }
    return "";
  }



}
