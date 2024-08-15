import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/category.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/repository/category_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/product_repository.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/screen/upload_products/view/upload_products_page.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UploadProductsController extends GetxController {
  ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  List<String> listImagePath = [];
  List<MyCategory> menu = [];
  var selectedFileCount = 0.obs;
  bool load = false;

  int currentIndex = 0;
  int currentIndexMenu = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController collectionName = TextEditingController();
  TextEditingController productDetails = TextEditingController();
  TextEditingController caption = TextEditingController();
  TextEditingController weight = TextEditingController();
  ProductRepository _productRepository = ProductRepository();
  PlatformFile? files;
  File? file_image;

  @override
  void onInit() {
    super.onInit();
    loadMenuCategory();
    reloadPage();
  }

  void initState() {}
  selectFile() async {
    final result = await FilePicker.platform.pickFiles(
        // type: FileType.custom,
        // allowMultiple: true,
        // allowedExtensions: ['.usdz']
        );

    if (result != null) {
      print('File Name: ${result.names}');
      print('File Path: ${result.paths}');
      PlatformFile file = result.files.first;
      file_image = File(result.files.first.path!);
      files = file;
      update();
    }
  }

  Future<void> loadMenuCategory() async {
    menu = await CategoryRepository().getCategories();
    for (int i = 0; i < menu.length; i++) {
      if (menu[i].name == "All") {
        menu.removeAt(i);
        break;
      }
    }
    update();
  }

  void onSeletedMenu(int index) {
    currentIndexMenu = index;
    update();
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

  Future<void> saveFilePermanetly(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
  }

  void reload() {
    load = true;
    update();
  }

  Future<void> post() async {
    reload();
    Product _product = Product(
      name: nameController.text,
      price: double.parse(priceController.text),
      category: menu[currentIndexMenu].path,
      imagePath: listImagePath,
      imageColorTheme: pickColored,
      caption: caption.text,
      height: double.parse(heightController.text),
      length: double.parse(lengthController.text),
      width: double.parse(widthController.text),
      description: productDetails.text,
      weight: double.parse(weight.text),
      linkAR: files != null ? files?.path.toString() : null,
    );

    await _productRepository.addProduct(_product, menu[currentIndexMenu]);
    Get.snackbar("Add successfully", "");
    reloadPage();
  }

  void reloadPage() {
    nameController.clear();
    priceController.clear();
    caption.clear();
    heightController.clear();
    lengthController.clear();
    widthController.clear();
    productDetails.clear();
    productDetails.clear();
    listImagePath = [];
    weight.clear();
    images = [];
    selectedFileCount.value = 0;
    pickColored = [];
    files = null;
    load = false;
    update();
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

  void deleteImage(int index) {
    listImagePath.removeAt(index);
    update();
  }
}
