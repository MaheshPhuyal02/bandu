import 'package:bandu/models/task/sub_task.dart';
import 'package:bandu/models/task/task.dart';
import 'package:bandu/models/user/db_user.dart';
import 'package:bandu/models/user/user_project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbManager {
//   instance
  static final DbManager instance = DbManager._internal();

  factory DbManager() => instance;

  DbManager._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _currentProjectId = '';
  Project? _currentProject = null;
  String _uid = '';

  set uid(String uid) {
    _uid = uid;
  }

  Future<Project?> getCurrentProject() {
    if (_currentProject != null) {
      return Future.value(_currentProject);
    }

    return _firestore
        .collection('projects')
        .doc(_uid)
        .collection('user_projects')
        .doc(_currentProjectId)
        .get()
        .then((value) {
      if (!value.exists) return null;
      _currentProject = Project.fromJson(value.data()!);
      return Project.fromJson(value.data()!);
    });
  }

  void setCurrentProjectId(String projectId) {
    _currentProjectId = projectId;
  }

  Future<bool> hasUserData(String uid) {
    return _firestore.collection('users').doc(uid).get().then((value) {
      if (value.exists) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> addUser(DBUser user) {
    return _firestore
        .collection('users')
        .doc(user.uid)
        .set(user.toJson())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> addProject(Project project, String uid) {
    return _firestore
        .collection('projects')
        .doc(uid)
        .collection('user_projects')
        .doc(project.id)
        .set(project.toJson())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) {
    return _firestore.collection('users').doc(uid).get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> listerUser(String uid) {
    return _firestore.collection('users').doc(uid).snapshots();
  }

  void updateUser(DBUser dbUser, String uid) {
    _firestore.collection('users').doc(uid).update({
      'workAs': dbUser.workAs,
      'completed': dbUser.completed,
      'email': dbUser.email,
      'name': dbUser.name,
      'role': dbUser.role,
      'createdAt': dbUser.createdAt,
      'provider': dbUser.provider,
      'projects': dbUser.projects == null
          ? []
          : [for (var project in dbUser.projects!) project.toJson()],
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTasks() {
    print('streaming tasks for project $_currentProjectId');
    return _firestore
        .collection('projects')
        .doc(_uid)
        .collection('user_projects')
        .doc(_currentProjectId)
        .collection('tasks')
        .snapshots();
  }

  Future<void> addTask(Task task) async {
    print('adding task to project $_currentProjectId');

    List<SubTask> subTasks = task.subTask;

    if (_currentProjectId.isEmpty) throw Exception('Project ID is empty');
    await _firestore
        .collection('projects')
        .doc(_uid)
        .collection('user_projects')
        .doc(_currentProjectId)
        .collection('tasks')
        .doc(task.id)
        .set({
      'id': task.id,
      'title': task.title,
      'description': task.description,
      'createdDate': task.createdDate,
      'deadline': task.deadline,
      'completed': task.completed,
      'status': task.status,
      'subTask': subTasks.map((e) => e.toJson()).toList(),
    });
  }

  void setUid(String uid) {
    _uid = uid;
  }

  Future<List<Project>?> getProjects() {
    return _firestore
        .collection('projects')
        .doc(_uid)
        .collection('user_projects')
        .get()
        .then((value) {
      if (value.docs.isEmpty) return null;
      return value.docs.map((e) => Project.fromJson(e.data())).toList();
    });
  }

  String generateId() {
    return _firestore.collection('projects').doc().id;
  }

  deleteProject(String id, String uid) {
    return _firestore
        .collection('projects')
        .doc(uid)
        .collection('user_projects')
        .doc(id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  updateSubTask(String taskId, String id, List<SubTask> task) {
    return _firestore
        .collection('projects')
        .doc(_uid)
        .collection('user_projects')
        .doc(_currentProjectId)
        .collection('tasks')
        .doc(taskId)
        .update({
      'subTask': task.map((e) => e.toJson()).toList(),
    });
  }

  deleteAllTask() {
    return _firestore
        .collection('projects')
        .doc(_uid)
        .collection('user_projects')
        .doc(_currentProjectId)
        .collection('tasks')
        .get()
        .then((value) {
      for (var doc in value.docs) {
        doc.reference.delete();
      }
    });
  }

  updateTask(Task task) {
    return _firestore
        .collection('projects')
        .doc(_uid)
        .collection('user_projects')
        .doc(_currentProjectId)
        .collection('tasks')
        .doc(task.id)
        .update({
      'title': task.title,
      'description': task.description,
      'createdDate': task.createdDate,
      'deadline': task.deadline,
      'completed': task.completed,
      'status': task.status,
      'id': task.id,
      'subTask': task.subTask.map((e) => e.toJson()).toList(),
    });
  }

  deleteTask(String id) {
    return _firestore
        .collection('projects')
        .doc(_uid)
        .collection('user_projects')
        .doc(_currentProjectId)
        .collection('tasks')
        .doc(id)
        .delete();
  }
}
