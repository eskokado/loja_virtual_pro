import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Fire;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/firebase_errors.dart';
import 'user.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final Fire.FirebaseAuth auth = Fire.FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  User? user;

  Future<void> signIn({
    required User user,
    required Function onFail,
    required Function onSuccess,
  }) async {
    loading = true;
    try {
      final Fire.UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      user = result.user as User;

      await Future.delayed(Duration(seconds: 5));

      onSuccess(result.user!.uid);
    } on Fire.FirebaseAuthException catch (e) {
      //print(e.code);
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp(
      {required User user,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final Fire.UserCredential result =
          await auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      user.id = result.user!.uid;

      await user.saveData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadCurrentUser({Fire.User? firebaseUser}) async {
    final Fire.User? currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      user = User.fromDocument(docUser);
      print(user!.name);
      notifyListeners();
    }
  }
}
