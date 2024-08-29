import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  static final _instance = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
  }

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> savePasswordChange() async {
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;
    String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

    if (newPassword != confirmPassword) {
      Get.snackbar(
        "Fail",
        "Confirm passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (currentUserEmail == null) {
      Get.snackbar(
        "Fail",
        "Email does not exist",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // Re-authenticate user
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: currentUserEmail,
        password: oldPassword,
      );

      // Change password
      await userCredential.user?.updatePassword(newPassword);
      Get.snackbar(
        "Succeed",
        "Change password successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Get.snackbar(
          "Fail",
          "Incorrect password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          "Đã xảy ra lỗi: ${e.message}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Lỗi",
        "Đã xảy ra lỗi không xác định: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
