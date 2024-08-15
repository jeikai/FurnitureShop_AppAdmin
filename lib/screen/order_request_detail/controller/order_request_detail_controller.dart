import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/request_order.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/order.dart';
import '../../../data/models/product.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/repository/product_repository.dart';
import '../../../data/values/strings.dart';

class OrderRequestDetailController extends GetxController {
  TextEditingController noteText = TextEditingController();
  TextEditingController reasonText = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  List<String> listImagePath = [];
  late RequestOrder orders;
  late UserProfile user;
  List<Product> products = [];
  bool load = true;

  @override
  void onInit() {
    super.onInit();
    loadRequest();
  }

  Future<void> loadRequest() async {
    orders = Get.arguments['order'];
    user = Get.arguments['user'];
  }

  String swapStatus(int status) {
    String titleStatus = '';
    if (status == 1) {
      titleStatus = titleLoading;
      return titleStatus;
    } else if (status == 2) {
      titleStatus = titleDilivery;
      return titleStatus;
    } else {
      titleStatus = titleFinish;
      return titleStatus;
    }
  }

  void selectedImage() async {
    images = await _picker.pickMultiImage();
    if (images != null) {
      for (XFile file in images!) {
        listImagePath.add(file.path);
      }
    } else {
      Get.snackbar("Fail", "No Image selected", snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: WHITE);
    }
    update();
  }

  void deleteImage(int index) {
    listImagePath.removeAt(index);
    update();
    print(index);
  }
}
