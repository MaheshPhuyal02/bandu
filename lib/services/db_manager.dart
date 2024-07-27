import 'package:bandu/models/user/db_user.dart';
import 'package:bandu/models/user/user_project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbManager {
//   instance
  static final DbManager instance = DbManager._internal();

  factory DbManager() => instance;

  DbManager._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}
