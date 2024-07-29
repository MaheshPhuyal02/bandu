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
  String _uid = '';

  set uid(String uid) {
    _uid = uid;
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
    _firestore.collection('users').doc(uid).update(dbUser.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTasks() {
    return _firestore
        .collection('projects')
        .doc(_uid)
        .collection('user_projects')
        .doc(_currentProjectId)
        .collection('tasks')
        .snapshots();
  }

  Future<void> addTask(Task task) async {
    if (_currentProjectId.isEmpty) throw Exception('Project ID is empty');
    await _firestore
        .collection('projects')
        .doc(_uid)
        .collection('user_projects')
        .doc(_currentProjectId)
        .collection('tasks')
        .add(task.toJson());
  }

  void setUid(String uid) {
    _uid = uid;
  }

  Future<List<Project>> getProjects() {
    return _firestore
        .collection('projects')
        .doc(_uid)
        .collection('user_projects')
        .get()
        .then((value) {
      return value.docs
          .map((e) => Project.fromJson(e.data()))
          .toList();
    });
  }

  String generateId() {
    return _firestore.collection('projects').doc().id;
  }
}
