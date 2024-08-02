import 'package:bandu/main.dart';
import 'package:bandu/models/user/user_project.dart';
import 'package:bandu/routes/app_router.gr.dart';
import 'package:bandu/services/SharedPref.dart';
import 'package:bandu/services/db_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/user/db_user.dart';

class AuthManager {
  //instance
  static final AuthManager instance = AuthManager._internal();

  factory AuthManager() => instance;

  AuthManager._internal();

  String _error = '';
  DBUser? _user;

  DbManager? dbManager;

  AuthStatus status = AuthStatus.loading;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> init() async {
    print("AuthManager ::: Initializing AuthManager");

    dbManager = DbManager.instance;
    if (hasLoggedIn()) {
      dbManager?.setUid(_auth.currentUser!.uid);
    }

    if (_auth.currentUser != null) {
      print("AuthManager ::: User is already logged in");
      await initializeUser();
      validateUser();
    } else {
      print("AuthManager ::: User is not logged in");
      status = AuthStatus.unauthenticated;
    }
  }

  Future<void> loginWithEmailPass(String email, String pass) async {
    status = AuthStatus.loading;
    print("AuthManager ::: Logging in with email and password");
    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) async {
      status = AuthStatus.authenticated;

      await initializeUser();
      validateUser();
    }).catchError((error) {
      _error = error.toString();
      status = AuthStatus.error;
    });
  }

  Future<void> resetPassword(String email) async {
    print("AuthManager ::: Resetting password");
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> loginWithGoogle() async {
    status = AuthStatus.loading;
    print("AuthManager ::: Logging in with Google");
    AuthProvider provider = GoogleAuthProvider();
    UserCredential val = await _auth.signInWithProvider(provider);
    if (val.user != null) {
      status = AuthStatus.authenticated;
      String name = val.user!.displayName ?? "";
      String email = val.user!.email ?? "";

      await _handleRegister(name, email, "google");
      await initializeUser();
      validateUser();
    } else {
      _error = "Failed to login with Google";
      status = AuthStatus.error;
    }
  }

  Future<void> register(String name, String email, String pass) async {
    print("AuthManager ::: Registering with email and password");
    status = AuthStatus.loading;
    _auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) async {
      status = AuthStatus.authenticated;
      await _handleRegister(name, email, "email");
      await initializeUser();
      validateUser();
    }).catchError((error) {
      _error = error.toString();
      status = AuthStatus.error;
    });
  }

  Future<void> validateUser() async {
    print("AuthManager ::: Validating user :: " + _user.toString());
    dbManager?.setUid(_auth.currentUser!.uid);

    if (_user == null) {
      appRouter.pushAndPopUntil(Complete_profileRoute(),
          predicate: (route) => false);
    } else if (_user!.completed == false) {
      appRouter.pushAndPopUntil(Complete_profileRoute(),
          predicate: (route) => false);
    } else if (_user!.projects == null ||
        _user!.projects!.isEmpty ||
        SharedPref.instance.getValue("currentProjectId") == null) {
      appRouter.pushAndPopUntil(
        SelectProjectRoute(canGoBack: false),
        predicate: (route) => false,
      );
    } else {
      dbManager?.setCurrentProjectId(
          SharedPref.instance.getValue("currentProjectId"));
      appRouter.pushAndPopUntil(HomeMainRoute(), predicate: (route) => false);
    }
  }

  Future<void> _handleRegister(
      String name, String email, String provider) async {
    print("AuthManager ::: Handling register");
    DBUser user = DBUser(
        uid: _auth.currentUser!.uid,
        name: name,
        email: email,
        createdAt: DateTime.now(),
        provider: provider,
        completed: false);

    await dbManager?.addUser(user);

    _user = user;

    validateUser();
  }

  Future<bool?> hasUserData() async {
    print("AuthManager ::: Checking if user data exists");
    return await dbManager?.hasUserData(_auth.currentUser!.uid);
  }

  Future<void> initializeUser() async {
    if (_auth.currentUser == null) {
      return;
    }
    print("AuthManager ::: Initializing user " + _auth.currentUser!.uid);
    DocumentSnapshot<Map<String, dynamic>>? data =
        await dbManager?.getUserData(_auth.currentUser!.uid);
    if (data?.data() != null) {
      _user = DBUser.fromJson(data!.data()!);
    } else {
      _user = null;
    }
    print("AuthManager ::: User initialized :: " + _user.toString());
  }

  bool hasLoggedIn() {
    print("AuthManager ::: Checking if user is logged in");
    return _auth.currentUser != null;
  }

  String getError() {
    return _error;
  }

  void updateWorkAs({
    required String workAs,
  }) {
    print("AuthManager ::: Updating user");
    _user = _user?.copyWith(workAs: workAs, completed: true);
    dbManager?.updateUser(_user!, _auth.currentUser!.uid);
  }

  void logout() {
    print("AuthManager ::: Logging out");
    _auth.signOut();
    status = AuthStatus.unauthenticated;
    _user = null;
    appRouter.pushAndPopUntil(LoginRoute(), predicate: (route) => false);
  }

  DBUser? getUser() {
    return _user;
  }

  void addProject(Project project){
    if(_user?.projects == null){
      _user = _user?.copyWith(projects: []);
    }

    List<Project> projects = List.from(_user!.projects!);
    projects.add(project);

    _user = _user?.copyWith(projects: projects);

    print("AuthManager ::: Adding project : " + _user!.toJson().toString());
    dbManager?.updateUser(_user!, _auth.currentUser!.uid);
  }

}

enum AuthStatus { loading, authenticated, unauthenticated, error }

enum UserStatus { loading, error, failedToRetrieve, success }
