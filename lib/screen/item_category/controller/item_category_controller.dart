import 'package:furnitureshop_appadmin/data/models/category.dart';
import 'package:furnitureshop_appadmin/data/repository/category_repository.dart';
import 'package:get/get.dart';

class ItemCategoryController extends GetxController {
  List<MyCategory> categoryEmpty = [];
  List<String> menuIconPaths = [];
  int currentIndex = 0;
  final CategoryRepository _categoryRepository = CategoryRepository();

  @override
  void onInit() {
    super.onInit();
    updateMenuIconPaths();
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
}
