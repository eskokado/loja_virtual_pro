import 'package:firebase_auth/firebase_auth.dart' as Fire;
import 'package:flutter/material.dart';

import '../helpers/firebase_errors.dart';
import 'user.dart';

class UserManager extends ChangeNotifier {
  final Fire.FirebaseAuth auth = Fire.FirebaseAuth.instance;

  bool loading = false;

  Future<void> signIn({
    required User user,
    required Function onFail,
    required Function onSuccess,
  }) async {
    setLoading(true);
    try {
      final Fire.UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      await Future.delayed(Duration(seconds: 5));

      onSuccess(result.user!.uid);
    } on Fire.FirebaseAuthException catch (e) {
      //print(e.code);
      onFail(getErrorString(e.code));
    }
    setLoading(false);
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
