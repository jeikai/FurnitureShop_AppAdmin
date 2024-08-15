import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furnitureshop_appadmin/data/repository/admin_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/user_repository.dart';

import '../models/account_admin.dart';

class AuthService {
  static final _instance = FirebaseAuth.instance;

  static String? get userId {
    return _instance.currentUser?.uid;
  }

  static Stream<User?> get authChanges {
    return _instance.authStateChanges();
  }

  static Future<UserCredential> signInAnonymous() async {
    return _instance.signInAnonymously();
  }

  static Future<UserCredential?> signUp(Admin admin, String password) async {
    UserCredential? newUserCredential;
    if (admin.email == null || password == '') return null;
    try {
      newUserCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: admin.email.toString(),
        password: password,
      );

      await AdminRepository().addStaff(admin, newUserCredential.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    }
    return newUserCredential;
  }

  static Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    UserCredential? firebaseUser;

    try {
      // Query the account_admin collection for a matching email and password
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('account_admin')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If a match is found, sign in the user
        firebaseUser = await _instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        // If no match is found, throw an error or return null
        Fluttertoast.showToast(
          msg: "Invalid email or password",
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    }

    print("Return");
    print(firebaseUser);
    return firebaseUser;
  }


  // sign out
  static Future<void> signOut() async {
    try {
      return await _instance.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    }
  }

  static void _handleAuthError(FirebaseAuthException e) {
    // String msg = FirebaseAuthHelper.getToastMessage(e.code);
    // Fluttertoast.showToast(msg: msg);
    // debugPrint(msg);
  }
}
