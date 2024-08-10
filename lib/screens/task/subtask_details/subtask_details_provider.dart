import 'package:bandu/models/task/sub_task.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../../models/task/task.dart';
import '../../../services/db_manager.dart';

class Subtask_detailsProvider extends ChangeNotifier {


  bool isTextEditable = false, isDescriptionEditable = false, isDeadlineEditable = false, isSubTaskEditable = false;

  final ConfettiController controllerCenter =
  ConfettiController(duration: const Duration(seconds: 1));

  TextEditingController textController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool showSublist = true;
  SubTask? subTask;

  Task? task;

  void init(SubTask subTask, Task task) {
    this.subTask = subTask;
    this.task = task;

    textController.text = subTask.title;
    descriptionController.text = subTask.description;

    notifyListeners();
  }


  void setEditable(String type, bool value) {
    switch (type) {
      case "text":
        isTextEditable = value;
        break;
      case "description":
        isDescriptionEditable = value;
        break;
      case "deadline":
        isDeadlineEditable = value;
        break;
      case "subTask":
        isSubTaskEditable = value;
        break;
    }
    notifyListeners();
  }



  Future<void> updateSubStatus(String status) async {
    subTask?.status = status;
    subTask?.updatedDate = DateTime.now();
    task?.subTask.forEach((element) {
      if(element.id == subTask!.id){
        element.status = status;
        return;
      }
    });

    DbManager.instance.updateTask(task!);
    notifyListeners();
  }

  Future<void> deleteSubTask(
      BuildContext context,
      String id) async {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Delete Sub Task"),
        content: Text("Are you sure you want to delete this sub task?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              task?.subTask.removeWhere((element) => element.id == id);
              await DbManager.instance.updateTask(task!);
              Navigator.pop(context);
              notifyListeners();
            },
            child: Text("Delete"),
          ),
        ],
      );
    });
  }
  void updateTitle(String value) {
    print("UPDATE TITLE");

    task?.subTask.forEach((element) {
      if(element.id == subTask!.id){
        element.title = value;
        element.updatedDate = DateTime.now();
        return;
      }
    });


    DbManager.instance.updateTask(task!);
    notifyListeners();
  }

  void updateDescription() {


    task?.subTask.forEach((element) {
      if(element.id == subTask!.id){
        element.description = descriptionController.text;
        element.updatedDate = DateTime.now();
        return;
      }
    });

    DbManager.instance.updateTask(task!);
    notifyListeners();
  }

  void showDeadlinePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: task!.deadline!.isAfter(DateTime.now()) ? task!.deadline : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {

        if(value.isBefore(DateTime.now())){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Deadline cannot be in the past"),
          ));
          return;
        }

        task?.subTask.forEach((element) {
          if(element.id == subTask!.id){
            element.deadline = value;
            element.updatedDate = DateTime.now();
            return;
          }
        });

        DbManager.instance.updateTask(task!);
        notifyListeners();
      }
    });
  }

}
