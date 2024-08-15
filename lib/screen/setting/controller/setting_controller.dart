import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/account_admin.dart';
import 'package:furnitureshop_appadmin/data/repository/admin_repository.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  late Admin admin;
  bool load = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    //loadPage();
    admin = Get.arguments['admin'];
    fullNameController = TextEditingController(text: admin.name);
    emailController = TextEditingController(text: admin.email);
  }

  bool isSwitched = true;

  void onSwitchedType(bool value) {
    if (value == true) {
      isSwitched = true;
    } else if (value == false) {
      isSwitched = false;
    }
    update();
  }

  void loadUpdateUser() {
    load = true;
    update();
  }

  Future<void> loadPage() async {
    load = true;
    admin = await AdminRepository().getUserProfile();
    update();
  }

  // getAvatar() {
  //   if (imagePath != null) return FileImage(File(imagePath.toString()));
  //   if (users.avatarPath != null) return NetworkImage(users.avatarPath!);
  //   return AssetImage('assets/images/avatar.png');
  // }
}
