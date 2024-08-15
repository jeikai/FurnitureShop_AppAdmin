import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/repository/order_repository.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:get/get.dart';
import '../../../data/models/order.dart';
import '../../../data/models/user_profile.dart';
import 'package:furnitureshop_appadmin/data/repository/product_repository.dart';

class ListOrderDetailController extends GetxController {
  late Order order;
  late UserProfile user;
  List<Product> products = [];
  String id = "";
  bool load = true;
  @override
  void onInit() {
    super.onInit();
    loadProduct();
  }

  Future<void> loadProduct() async {
    order = Get.arguments['order'];
    user = Get.arguments['user'];
    if (Get.arguments['order'] != null) {
      for (int i = 0; i < order.carts.length; i++) {
        Product p = await ProductRepository().getProduct(order.carts[i].idProduct);
        products.add(p);
      }
      load = false;
      update();
    }
  }

  String swapStatus(int status) {
    String titleStatus = '';
    if (status == 1) {
      titleStatus = titleLoading;
      return titleStatus;
    } else if (status == 2) {
      titleStatus = titleDilivery;
      return titleStatus;
    } else {
      titleStatus = titleFinish;
      return titleStatus;
    }
  }

  Color getColorStatus() {
    int status = OrderRepository().statusOrderToInt(order);
    if (status == 2) return Colors.blue;
    if (status == 3) return textGreenColor;
    if (status == 4) return buttonColor;
    return Colors.red;
  }
}
