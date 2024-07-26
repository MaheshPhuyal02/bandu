import 'package:bandu/main.dart';
import 'package:bandu/routes/app_router.gr.dart';
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
    print("AuthManager ::: Initializing AuthManager");

    dbManager = DbManager.instance;

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

  Future<void> loginWithGoogle() async {
    print("AuthManager ::: Logging in with Google");
    AuthProvider provider = GoogleAuthProvider();
    _auth.signInWithPopup(provider).then((value) async {
      status = AuthStatus.authenticated;
      await initializeUser();
      validateUser();
    }).catchError((error) {
      _error = error.toString();
      status = AuthStatus.error;
    });
  }

  Future<void> register(String name, String email, String pass) async {
    print("AuthManager ::: Registering with email and password");
    _auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      status = AuthStatus.authenticated;
      _handleRegister(name, email);
    }).catchError((error) {
      _error = error.toString();
      status = AuthStatus.error;
    });
  }

  Future<void> validateUser() async {
    print("AuthManager ::: Validating user :: " + _user.toString());
    if (_user == null) {
      appRouter.pushAndPopUntil(Complete_profileRoute(),
          predicate: (route) => false);
    } else if (_user!.completed == false) {
      appRouter.pushAndPopUntil(Complete_profileRoute(),
          predicate: (route) => false);
    } else {
      appRouter.pushAndPopUntil(HomeMainRoute(), predicate: (route) => false);
    }
  }

  void _handleRegister(String name, String email) {
    print("AuthManager ::: Handling register");
    DBUser user = DBUser(name: name, email: email, completed: false);

    dbManager?.addUser(user).then((value) {
      if (value) {
        _user = user;
        status = AuthStatus.authenticated;
        appRouter.pushAndPopUntil(Complete_profileRoute(),
            predicate: (route) => false);
      } else {
        _error = "Failed to register";
        status = AuthStatus.error;
      }
    });
  }

  Future<bool?> hasUserData() async {
    print("AuthManager ::: Checking if user data exists");
    return await dbManager?.hasUserData(_auth.currentUser!.uid);
  }

  Future<void> initializeUser() async {
    print("AuthManager ::: Initializing user");
    dbManager?.listerUser(_auth.currentUser!.uid).listen((event) {
      if (event.data() == null) {
        return;
      }
      _user = DBUser.fromJson(event.data()!);
    });
  }

  bool hasLoggedIn() {
    print("AuthManager ::: Checking if user is logged in");
    return status == AuthStatus.authenticated;
  }

  String getError() {
    return _error;
  }
}

enum AuthStatus { loading, authenticated, unauthenticated, error }

enum UserStatus { loading, error, failedToRetrieve, success }
