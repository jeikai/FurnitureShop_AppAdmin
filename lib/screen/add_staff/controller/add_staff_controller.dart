import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/auth/auth_service.dart';
import 'package:furnitureshop_appadmin/data/models/account_admin.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:get/get.dart';

class AddStaffController extends GetxController {
  bool load = false;
  bool check = false;
  int selected = 0;
  List<String> roles = [
    "Manage",
    "Sale"
  ];
  var isPasswordHidden = true.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onSelected(int? value) {
    if (value != null) {
      selected = value;
      update();
    }
  }

  showRatingDialog() {
    Get.dialog(
      AlertDialog(
          title: Text("Add Staff Successful"),
          content: Container(
            width: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      "UserName:",
                      style: TextStyle(fontSize: Get.width * 0.051, color: textBlackColor),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      nameController.text,
                      style: TextStyle(fontSize: Get.width * 0.051, fontWeight: FontWeight.w600, color: textBlackColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Email:",
                      style: TextStyle(fontSize: Get.width * 0.051, color: textBlackColor),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${emailController.text}@amigo.vn',
                      style: TextStyle(fontSize: Get.width * 0.051, fontWeight: FontWeight.w600, color: textBlackColor),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Future<void> submitStaff() async {
    String name = nameController.text;
    String email = emailController.text + "@amigo.vn";
    String phone = phoneController.text;
    String code = codeController.text;
    String password = passwordController.text;
    String role = roles[selected];
    await AuthService.signUp(Admin(name: name, phone: phone, code: code, email: email, role: role), password);
    showRatingDialog();
  }
}
