import 'package:flutter/cupertino.dart';
import 'package:furnitureshop_appadmin/data/models/category.dart';
import 'package:furnitureshop_appadmin/data/repository/category_repository.dart';
import 'package:get/get.dart';

class AddCategoryController extends GetxController {
  List<MyCategory> categoryEmpty = [];
  List<String> menuIconPaths = [];
  int currentIndex = 0;
  TextEditingController categoryName = TextEditingController();
  final CategoryRepository _categoryRepository = CategoryRepository();

  @override
  void onInit() {
    super.onInit();
    updateMenuIconPaths();
    // loadImageCategory();
  }

  Future<void> loadImageCategory() async {
    List<String> menuIconPaths = [
      'assets/category/icons8-armchair-50.png',
      'assets/category/icons8-balcony-50.png',
      'assets/category/icons8-bath-50.png',
      'assets/category/icons8-bathroom-mirror-50.png',
      'assets/category/icons8-book-shelf-50.png',
      'assets/category/icons8-bookcase-50.png',
      'assets/category/icons8-buffet-50.png',
      'assets/category/icons8-bunk-bed-50.png',
      'assets/category/icons8-bureau-50.png',
      'assets/category/icons8-ceiling-fan-on-50.png',
      'assets/category/icons8-chair-50.png',
      'assets/category/icons8-chandelier-50.png',
      'assets/category/icons8-closet-50.png',
      'assets/category/icons8-coffee-maker-50.png',
      'assets/category/icons8-coffee-roaster-50.png',
      'assets/category/icons8-coffee-table-50.png',
      'assets/category/icons8-console-table-50.png',
      'assets/category/icons8-cooker-50.png',
      'assets/category/icons8-cooker-50.png',
      'assets/category/icons8-cupboard-50.png',
      'assets/category/icons8-curtains-50.png',
      'assets/category/icons8-desk-50.png',
      'assets/category/icons8-desk-lamp-50.png',
      'assets/category/icons8-dishwasher-50.png',
      'assets/category/icons8-door-handle-50.png',
      'assets/category/icons8-double-bed-50.png',
      'assets/category/icons8-dressing-table-50.png',
      'assets/category/icons8-electric-stovetop-50.png',
      'assets/category/icons8-fridge-50.png',
      'assets/category/icons8-garbage-disposal-50.png',
      'assets/category/icons8-lamp-50.png',
      'assets/category/icons8-lava-lamp-50.png',
      'assets/category/icons8-lights-50.png',
      'assets/category/icons8-office-chair-50.png',
      'assets/category/icons8-rocking-chair-50.png',
      'assets/category/icons8-shutters-50.png',
      'assets/category/icons8-single-bed-50.png',
      'assets/category/icons8-sink-50.png',
      'assets/category/icons8-sleeper-chair-50.png',
      'assets/category/icons8-sliding-door-closet-50.png',
      'assets/category/icons8-staircase-50.png',
      'assets/category/icons8-table-50.png',
      'assets/category/icons8-table-lights-50.png',
      'assets/category/icons8-table-top-view-50.png',
      'assets/category/icons8-tableware-50.png',
      'assets/category/icons8-toilet-bowl-50.png',
      'assets/category/icons8-tv-50.png',
      'assets/category/icons8-window-shade-50.png',
      'assets/category/icons8-wing-chair-50.png',
      'assets/category/icons8-wooden-floor-50.png',
      'assets/category/icons8-structural-50.png'
    ];
    menuIconPaths.forEach((element) async {
      await CategoryRepository().addNewImage(MyCategory(imagePath: element));
    });
  }

  Future<void> updateMenuIconPaths() async {
    categoryEmpty = await _categoryRepository.getImageCategories();
    menuIconPaths = [];
    for (var element in categoryEmpty) {
      menuIconPaths.add(element.imagePath.toString());
    }
    update();
  }

  void onSeletedMenu(int index) {
    currentIndex = index;
    update();
  }

  Future<void> add() async {
    print(categoryName.text.trim());
    if (categoryEmpty.isEmpty) {
      Get.snackbar("Error", "No categories available to add.");
      return;
    }

    MyCategory dataAdd = categoryEmpty[currentIndex];
    dataAdd.name = categoryName.text.trim();

    await _categoryRepository.addNewCategory(dataAdd);
    await _categoryRepository.deletedImageCategory(categoryEmpty[currentIndex].id.toString());

    await updateMenuIconPaths();
    categoryName.clear();
    Get.snackbar("Add successfully", "");
  }

}
