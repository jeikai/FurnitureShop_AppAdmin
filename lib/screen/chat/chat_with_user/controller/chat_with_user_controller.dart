import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/message_model.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';
import 'package:furnitureshop_appadmin/data/repository/message_repository.dart';
import 'package:get/get.dart';

class ChatWithUserController extends GetxController {
  late UserProfile user;
  TextEditingController messageText = TextEditingController();
  @override
  void onInit() {
    if (Get.arguments != null) {
      user = Get.arguments;
    } else {
      user = UserProfile(name: "user does not exist");
    }
    super.onInit();
  }

  Future<void> sendMessage() async {
    if (user.id.toString().trim() != "") {
      String text = messageText.text;
      messageText.clear();
      await MessageRepository().sendMessage(text, user);
    }
  }
}
