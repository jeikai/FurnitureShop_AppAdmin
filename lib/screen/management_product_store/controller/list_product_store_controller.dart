import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furnitureshop_appadmin/data/models/product_store.dart';
import 'package:furnitureshop_appadmin/data/repository/product_store_repository.dart';
import 'package:get/get.dart';

class ManagementProductStoreController extends GetxController {
  List<ProductStore> products = [];
  TextEditingController amountEditting = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    products = await ProductStoreRepository().getProductsStore();
    update();
  }

  Future<void> updateAmountProductStore(ProductStore productStore) async {
    if (amountEditting.text == "") {
      Fluttertoast.showToast(msg: "Number empty");
    }
    int number = int.parse(amountEditting.text.toString());
    if (productStore.id != null) {
      await ProductStoreRepository().updateAmountProductStore(productStore.id!, number);
      Fluttertoast.showToast(msg: "Update product successfully");
    }
    Get.back();
  }
}
