import 'package:furnitureshop_appadmin/data/models/discount.dart';
import 'package:furnitureshop_appadmin/data/values/images.dart';
import 'package:get/get.dart';

class DiscountDetailController extends GetxController {
  late MyDiscount discount;
  @override
  void onInit() {
    super.onInit();
    print(Get.height);
    discount = Get.arguments['discount'];
    update();
  }
}
