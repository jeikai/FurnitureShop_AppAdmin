import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furnitureshop_appadmin/data/auth/auth_service.dart';
import 'package:furnitureshop_appadmin/data/repository/user_repository.dart';
import 'package:furnitureshop_appadmin/screen/bottom_bar/view/bottom_bar_page.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var isPasswordHidden = true.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> login() async {
    UserCredential? user = await AuthService.signInWithEmailAndPassword(
        format(emailController.text), format(passwordController.text));
    if (user != null) {
      // bool check = await UserRepository()
      //     .checkAccountAdmin(FirebaseAuth.instance.currentUser!.uid);
      // if (check) {
      Get.to(const BottomBarPage());
    } else {
      Fluttertoast.showToast(
        msg: "This account is not an Admin account",
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      AuthService.signOut();
      // }
    }
  }

  String format(String st) {
    return st.trim();
  }
}
