import 'package:furnitureshop_appadmin/data/models/product_store.dart';
import 'package:furnitureshop_appadmin/data/repository/product_store_repository.dart';
import 'package:get/get.dart';

class ChooseProductController extends GetxController {
  List<ProductStore> productList = [];
  List<bool> check = [];
  String searchQuery = '';

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    productList = await ProductStoreRepository().getProductsStoreNotEmpty();
    check = List.filled(productList.length, false);
    update();
  }

  void chooseProduct(int index) {
    check[index] = check[index] ? false : true;
    update();
  }

  void search(String value) {
    if (value == '') return;
    List<ProductStore> product1 = [];
    List<bool> check1 = [];
    List<ProductStore> product2 = [];
    List<bool> check2 = [];
    // product.name.toLowerCase().contains(query.toLowerCase())
    for (int i = 0; i < productList.length; i++) {
      if (productList[i].name.toString().toLowerCase().contains(value.toLowerCase())) {
        product1.add(productList[i]);
        check1.add(check[i]);
      } else {
        product2.add(productList[i]);
        check2.add(check[i]);
      }
    }
    productList = [];
    productList.addAll(product1);
    productList.addAll(product2);
    check = [];
    check.addAll(check1);
    check.addAll(check2);
    update();
  }

  void back() {
    List<ProductStore> product = [];
    for (int i = 0; i < productList.length; i++) {
      if (check[i]) {
        product.add(productList[i]);
      }
    }
    Get.back(result: product);
  }
}
