// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furnitureshop_appadmin/data/models/discount.dart';
import 'package:furnitureshop_appadmin/data/repository/discount_repository.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddDiscountController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  XFile? images;
  String? imagePath;
  bool load = false;
  int selected = 0;
  List<String> roles = [
    "Discount Online",
    "Discount Game",
    "Discounts at the Store"
  ];

  TextEditingController nameDisController = TextEditingController();
  TextEditingController percentController = TextEditingController();
  TextEditingController timeStartController = TextEditingController();
  TextEditingController timeEndController = TextEditingController();
  TextEditingController priceStart = TextEditingController();
  TextEditingController priceLimit = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController scoreController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  void selectedImage() async {
    images = await _picker.pickImage(source: ImageSource.gallery);
    if (images != null) {
      imagePath = images!.path;
    } else {
      Get.snackbar("Fail", "No Image selected", snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: WHITE);
    }
    update();
  }

  void deleteImage() {
    imagePath = null;
    update();
  }

  void loadAddDiscount() {
    load = true;
    update();
  }

  void onSelected(int? value) {
    if (value != null) {
      selected = value;
      update();
    }
  }

  void reloadPage() {
    load = false;
    images = null;
    imagePath = null;
    nameDisController.clear();
    percentController.clear();
    timeStartController.clear();
    timeEndController.clear();
    priceStart.clear();
    priceLimit.clear();
    number.clear();
    scoreController.clear();
    codeController.clear();
    update();
  }

  bool checkData() {
    int check = 0;
    if (nameDisController.text == null) {
      check++;
    }
    if (timeStartController.text == null) {
      check++;
    }
    if (timeEndController.text == null) {
      check++;
    }
    if (number.text == null) {
      check++;
    }
    if (percentController.text == null) {
      check++;
    }
    if (priceStart.text == null) {
      check++;
    }
    if (priceLimit.text == null) {
      check++;
    }
    if (selected == 1 && scoreController.text == "") {
      check++;
    }
    if (selected == 2 && codeController.text == "") {
      check++;
    }
    if (check == 0) return true;
    return false;
  }

  Future<void> addDiscount() async {
    loadAddDiscount();
    if (checkData()) {
      MyDiscount discount = MyDiscount(
        name: nameDisController.text.toString(),
        imageNetwork: imagePath.toString(),
        timeStart: DateFormat('dd/MM/yyyy').parse(timeStartController.text.toString()),
        timeEnd: DateFormat('dd/MM/yyyy').parse(timeEndController.text.toString()),
        number: int.parse(number.text.toString()),
        percent: int.parse(percentController.text.toString()),
        priceStart: double.parse(priceStart.text.toString()),
        priceLimit: double.parse(priceLimit.text.toString()),
        isGame: selected == 1,
        isOffline: selected == 2,
        isOnline: selected == 0,
        codeStore: selected == 2 ? codeController.text.toString() : "",
        score: selected == 1 ? int.parse(scoreController.text.toString()) : 0,
      );
      await DiscountRepository().addDiscount(discount);
      Fluttertoast.showToast(msg: "Add discount successfull");
    } else {
      Fluttertoast.showToast(msg: "Data error");
    }
    reloadPage();
  }
}
