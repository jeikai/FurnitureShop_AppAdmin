import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/repository/product_repository.dart';
import 'package:get/get.dart';

class ItemProductController extends GetxController {
  List<Product> products = [];
  //late Product product;

  Product product = Product(
    id: 1.toString(),
    name: "Lamp",
    price: 230,
    imageColorTheme: [
      Colors.red,
      Colors.black
    ],
  );

  @override
  void onInit() {
    super.onInit();
    loadProduct();
  }

  Future<void> loadProduct() async {
    if (Get.arguments['category_path'] != null) {
      products = await ProductRepository().getProductsByCategory(Get.arguments['category_path']);
      update();
      // product = await ProductRepository().getProduct(Get.arguments['product']);
      // update();
    }
  }

  Future<void> deleteProductWithId(int index) async {
    if (products[index].id != null) {
      await ProductRepository().deleteProduct(products[index]);
    }
    products[index].isDeleted = DateTime.now();
    update();
  }

  Future<void> undoDeleteProductWithId(int index) async {
    if (products[index].id != null) {
      await ProductRepository().undoDeleteProduct(products[index]);
    }
    products[index].isDeleted = null;
    update();
  }

  String textDeletedProduct(Product product) {
    if (product.isDeleted == null) return 'Delete Products';
    return 'Undo deleted products';
  }

  Future<void> updateHotProductWithId(int index) async {
    if (products[index].id != null) {
      products[index].isHot = products[index].isHot ? false : true;
      await ProductRepository().updateProduct(products[index]);
      update();
    }
  }
}
