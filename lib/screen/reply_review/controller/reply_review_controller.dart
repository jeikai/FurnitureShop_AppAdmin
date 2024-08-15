import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furnitureshop_appadmin/data/auth/auth_service.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/models/review.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';
import 'package:furnitureshop_appadmin/data/repository/review_repository.dart';
import 'package:furnitureshop_appadmin/data/values/images.dart';
import 'package:get/get.dart';

class ReplyReviewController extends GetxController {
  TextEditingController replyReviewController = TextEditingController();
  bool load = false;
  late Review reviews;

  @override
  void onInit() {
    super.onInit();
    reviews = Get.arguments;
  }

  Future<void> reply() async {
    load == true;
    update();
    String reply = replyReviewController.text.toString().trim();
    if (reply == "") {
      Fluttertoast.showToast(msg: "Reply empty");
      load == false;
      update();
      return;
    }
    reviews.reply = reply;
    reviews.adminID = AuthService.userId;
    await ReviewRepository().updateReview(reviews);
    Get.back();
  }
}
