import 'package:furnitureshop_appadmin/data/models/category.dart';
import 'package:furnitureshop_appadmin/data/repository/category_repository.dart';
import 'package:get/get.dart';

class ManagementCategoryController extends GetxController {
  List<MyCategory> categorys = [];

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    categorys = await CategoryRepository().getCategories();
    for (int i = 0; i < categorys.length; i++) {
      if (categorys[i].path == 'all') {
        categorys.removeAt(i);
        break;
      }
    }
    update();
  }
}
