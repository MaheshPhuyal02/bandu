import 'package:bandu/services/db_manager.dart';
import 'package:bandu/services/ui_messages.dart';
import 'package:bandu/services/user_manager.dart';
import 'package:flutter/material.dart';

import '../../models/user/user_project.dart';

class SelectProjectProvider extends ChangeNotifier {
  List<Project> projects = [];
  String? title;

  TextEditingController titleController = TextEditingController();

  void init() {
    DbManager.instance.getProjects().then((value) {
      notifyListeners();
    });
  }

  Future<void> _addProject(String title, BuildContext context) async {
    String id = DbManager.instance.generateId();
    Project project =
        Project(title: title, lastUpdated: DateTime.now(), id: id);
    bool success = await DbManager.instance.addProject(project, AuthManager.instance.getUser()!.uid);
    if(success) {
      UiMessages.showMessage(
          context,
          "Project added successfully");
      projects.add(project);
      notifyListeners();
    }
    init();
  }

  void addNewProject(BuildContext context) {
    if(titleController.text.isEmpty) return;
    print("Adding project");
    _addProject(titleController.text, context);
  }


}
