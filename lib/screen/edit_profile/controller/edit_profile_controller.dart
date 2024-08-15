import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/account_admin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/values/colors.dart';

class EditProfileController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool load = false;
  String userId = '';
  ImagePicker _picker = ImagePicker();
  XFile? images;
  String? imagePath;
  late Admin admin;

  @override
  void onInit() {
    super.onInit();
    admin = Get.arguments['admin'];
    fullNameController = TextEditingController(text: admin.name);
    emailController = TextEditingController(text: admin.email);
  }

  void selectedImage() async {
    images = await _picker.pickImage(source: ImageSource.gallery);
    if (images != null) {
      // imagePath = images!.path;
    } else {
      Get.snackbar("Fail", "No Image selected",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: WHITE);
    }
    update();
  }

  // void loadUpdateUser() {
  //   load = true;
  //   update();
  // }

  // Future<void> updateUser() async {
  //   loadUpdateUser();
  //   users.name = fullNameController.text;
  //   if (imagePath != null) users.avatarPath = imagePath;
  //   await UserRepository().updateUser(users, updateImage: imagePath != null);
  //   Fluttertoast.showToast(msg: "Update user profile successfull");
  //   Get.back(result: true);
  // }

  //  Future<void> updateUserName( ) async {
  //   loadUpdateUser();
  //   UserProfile user = UserProfile(
  //     name: name.toString(),
  //     avatarPath: imagePath.toString(),
  //   );
  //   await UserRepository().updateUser(user);
  //   Fluttertoast.showToast(msg: "Update user profile successfull");
  //   Get.back();
  // }

  /* updateProfile(BuildContext context) async {
    Map<String, dynamic> map = Map();
    // if (avatarUrl != null) {
    //   String url = await uploadImage(avatarUrl);
    //   map['avatar'] = url;
    //   print('iiiii' + url);
    // }
    map['name'] = fullNameController.text;
    map['email'] = emailController.text;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
        .update(map)
        .then((value) {});
    Navigator.pop(context);
    Get.to(ProfilePage());
    update();
  }*/

  getAvatar() {
    // if (imagePath != null) return FileImage(File(imagePath.toString()));
    // if (users.avatarPath != null) return NetworkImage(users.avatarPath!);
    return AssetImage('assets/images/avatar.png');
  }
}
