import 'package:firebase_auth/firebase_auth.dart' as Fire;
import 'package:flutter/services.dart';

import '../helpers/firebase_errors.dart';
import 'user.dart';

class UserManager {
  final Fire.FirebaseAuth auth = Fire.FirebaseAuth.instance;

  Future<void> signIn({
    required User user,
    required Function onFail,
    required Function onSuccess,
  }) async {
    try {
      final Fire.UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      onSuccess(result.user!.uid);
    } on Fire.FirebaseAuthException catch (e) {
      //print(e.code);
      onFail(getErrorString(e.code));
    }
  }
}
