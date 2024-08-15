import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/repository/product_repository.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProductController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController productDetails = TextEditingController();
  TextEditingController caption = TextEditingController();
  TextEditingController weight = TextEditingController();

  List<String> image = [];
  ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  List<String> listImagePath = [];
  var selectedFileCount = 0.obs;
  bool load = false;
  late Product product;
  List<Color> pickColored = [];
  PlatformFile? files;
  File? file_AR;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments['product'];
    nameController.text = product.name.toString();
    priceController.text = product.price.toString();
    heightController.text = product.height.toString();
    weight.text = product.weight.toString();
    widthController.text = product.width.toString();
    lengthController.text = product.length.toString();
    caption.text = product.caption.toString();
    productDetails.text = product.description.toString();
    if (product.imagePath != null) image.addAll(product.imagePath!);
    pickColored = product.imageColorTheme ?? [];
    update();
    // if (product.listColor != null) pickColor.addAll(product.listColor!);
  }

  void selectedImage() async {
    images = await _picker.pickMultiImage();
    if (images != null) {
      for (XFile file in images!) {
        listImagePath.add(file.path);
      }
    } else {
      Get.snackbar("Fail", "No Image selected",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: WHITE);
    }
    update();
  }

  void deleteImage(int index) {
    listImagePath.removeAt(index);
    update();
  }

  void deleteFile() {
    files = null;
    update();
  }

  selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      print('File Name: ${result.names}');
      print('File Path: ${result.paths}');
      PlatformFile file = result.files.first;
      file_AR = File(result.files.first.path!);
      files = file;
      update();
    }
  }

  List<String> toColor(List<Color> color) {
    String result = color.toString();
    result = result.replaceAll("MaterialColor(primary value: Color(", "");
    result = result.replaceAll("Color(", "");
    result = result.replaceAll("[", "");
    result = result.replaceAll("]", "");
    result = result.replaceAll(")", "");
    result = result.replaceAll("),", ",");
    result = result.replaceAll(" ", "");
    return result.split(',');
  }

  Future<void> post() async {
    reload();
    product.name = nameController.text;
    product.price = double.parse(priceController.text);
    product.imageColorTheme = pickColored;
    product.caption = caption.text;
    product.height = double.parse(heightController.text);
    product.length = double.parse(lengthController.text);
    product.width = double.parse(widthController.text);
    product.description = productDetails.text;
    product.weight = double.parse(weight.text);
    await ProductRepository().updateProduct(product,
        link_ar: files != null ? files?.path.toString() : null,
        listImage: listImagePath.length > 0 ? listImagePath : null);
    Get.back(result: true);
    Get.snackbar(
        "Product update successful", "Products: ${nameController.text}");
  }

  void reload() {
    load = true;
    update();
  }

  // void reloadPage() {
  //   nameController.clear();
  //   priceController.clear();
  //   caption.clear();
  //   heightController.clear();
  //   lengthController.clear();
  //   widthController.clear();
  //   productDetails.clear();
  //   weight.clear();
  //   productDetails.clear();
  //   listImagePath = [];
  //   images = [];
  //   selectedFileCount.value = 0;
  //   pickColored = [];
  //   load = false;
  //   update();
  // }
}
