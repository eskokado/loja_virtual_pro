import 'package:firebase_auth/firebase_auth.dart' as Fire;
import 'package:flutter/material.dart';

import '../helpers/firebase_errors.dart';
import 'user.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final Fire.FirebaseAuth auth = Fire.FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  Fire.User? userFire;

  Future<void> signIn({
    required User user,
    required Function onFail,
    required Function onSuccess,
  }) async {
    loading = true;
    try {
      final Fire.UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      await Future.delayed(Duration(seconds: 5));

      userFire = result.user;

      onSuccess(result.user!.uid);
    } on Fire.FirebaseAuthException catch (e) {
      //print(e.code);
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    final Fire.User? currentUser = auth.currentUser;
    if (currentUser != null) {
      userFire = currentUser;
      print(userFire!.uid);
    }
    notifyListeners();
  }
}
