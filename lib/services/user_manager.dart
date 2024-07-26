import 'package:bandu/services/db_manager.dart';
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
    await Firebase.initializeApp();
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        status = AuthStatus.unauthenticated;
      } else {
        status = AuthStatus.authenticated;
      }
    });

    dbManager = DbManager.instance;
  }

  Future<void> loginWithEmailPass(String email, String pass) async {
    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) async {
      status = AuthStatus.authenticated;
      await initializeUser();
    }).catchError((error) {
      _error = error.toString();
      status = AuthStatus.error;
    });
  }

  Future<void> loginWithGoogle() async {
    AuthProvider provider = GoogleAuthProvider();
    _auth.signInWithPopup(provider).then((value) async {
      status = AuthStatus.authenticated;
      await initializeUser();
      _validateUser();
    }).catchError((error) {
      _error = error.toString();
      status = AuthStatus.error;
    });
  }

  Future<void> register(String email, String pass) async {
    _auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      status = AuthStatus.authenticated;
    }).catchError((error) {
      _error = error.toString();
      status = AuthStatus.error;
    });
  }

  Future<void> _validateUser() async {
    if (_user == null) {
      //   no user data move to profile page
    } else if (_user!.completed == false) {
      //   user data not completed move to profile page
    } else {
      //   user data completed move to home page
    }
  }

  void handleRegister(String name, String email) {
    DBUser user = DBUser(name: name, email: email, completed: false);

    dbManager?.addUser(user).then((value) {
      if (value) {
        _user = user;
        status = AuthStatus.authenticated;
      } else {
        _error = "Failed to register";
        status = AuthStatus.error;
      }
    });
  }

  Future<bool?> hasUserData() async {
    return await dbManager?.hasUserData(_auth.currentUser!.uid);
  }

  Future<void> initializeUser() async {
    dbManager?.listerUser(_auth.currentUser!.uid).listen((event) {
      if (event.data() == null) {
        return;
      }
      _user = DBUser.fromJson(event.data()!);
    });
  }
}

enum AuthStatus { loading, authenticated, unauthenticated, error }

enum UserStatus { loading, error, failedToRetrieve, success }
