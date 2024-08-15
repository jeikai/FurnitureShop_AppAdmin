import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furnitureshop_appadmin/data/models/account_admin.dart';
import 'package:furnitureshop_appadmin/data/models/bill.dart';
import 'package:furnitureshop_appadmin/data/models/discount.dart';
import 'package:furnitureshop_appadmin/data/models/product_store.dart';
import 'package:furnitureshop_appadmin/data/repository/bill_store_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/dashboard_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/discount_repository.dart';
import 'package:furnitureshop_appadmin/screen/dashboard/controller/dashboard_controller.dart';
import 'package:get/get.dart';

class SaleProductController extends GetxController {
  List<ProductStore> productList = [];
  List<int> number = [];
  double priceOrder = 0.0;
  double priceDiscount = 0.0;
  TextEditingController codeDiscount = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  DateTime now = DateTime.now();
  bool load = false;
  MyDiscount? discount;
  late Admin admin;
  @override
  void onInit() {
    super.onInit();
    admin = Get.arguments['admin'];
    loadUser();
  }

  Future<void> loadUser() async {
    await DashboardRepository().table1();
  }

  void addProductCard(List<ProductStore> product) {
    productList = [];
    productList.addAll(product);
    number = [];
    number.addAll(List.filled(productList.length, 1));
    priceOrder = 0;
    for (var element in productList) {
      priceOrder += element.price;
    }
    update();
  }

  Future<void> checkDiscount() async {
    if (codeDiscount.text.toString().trim() == '') {
      Fluttertoast.showToast(msg: "Code discount empty");
      return;
    }
    MyDiscount? dis = await DiscountRepository().getDiscountOffline(codeDiscount.text.toString().trim());
    if (dis == null) {
      Fluttertoast.showToast(msg: "Not found discount");
    } else {
      discount = dis;
      updatePriceDiscount();
    }
    update();
  }

  void removeProduct(int index) {
    priceOrder -= productList[index].price * number[index];
    productList.removeAt(index);
    number.removeAt(index);
    update();
  }

  void updatePriceDiscount() {
    if (discount != null && discount!.percent != null) {
      if (discount!.priceStart! > priceOrder) return;
      priceDiscount = priceOrder * discount!.percent! / 100;
      if (priceDiscount > discount!.priceLimit!) priceDiscount = discount!.priceLimit!;
    }
    update();
  }

  Future<void> clickSubmitButton() async {
    //load = true;
    update();
    for (int i = 0; i < productList.length; i++) {
      productList[i].number = number[i];
    }
    BillStore bill = BillStore(products: productList, nameSeller: admin.name, nameUser: nameController.text, phoneUser: phoneController.text, address: addressController.text, codeDiscount: codeDiscount.text, priceOrder: priceOrder, totalPrice: (priceOrder - priceDiscount), discount: priceDiscount, timeBuy: now);
    bool error = false;
    await BillStoreRepository().addToBill(bill).onError((errorSt, stackTrace) {
      Get.snackbar("Error", errorSt.toString());
      error = true;
    });
    if (error == false) Get.snackbar("Add successfully", error.toString());
    Get.back();
  }

  void reload() {}
}
