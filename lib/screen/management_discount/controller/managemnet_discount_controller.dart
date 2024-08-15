import 'package:furnitureshop_appadmin/data/models/discount.dart';
import 'package:furnitureshop_appadmin/data/repository/discount_repository.dart';
import 'package:get/get.dart';

class ManagementDiscountController extends GetxController {
  List<MyDiscount> discounts = [];
  List<MyDiscount> totalDiscounts = [];
  List<String> tab = [
    'Online',
    'Game',
    'Store',
  ];
  Rx<int> tabCurrentIndex = 0.obs;
  bool load = true;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    totalDiscounts = await DiscountRepository().getDiscounts();
    onChangePage(0);
  }

  void onChangePage(int index) async {
    tabCurrentIndex.value = index;
    if (tab[index] == 'Online') {
      discounts = [];
      totalDiscounts.forEach((element) {
        if (element.isOnline) discounts.add(element);
      });
    }
    if (tab[index] == 'Game') {
      discounts = [];
      totalDiscounts.forEach((element) {
        if (element.isGame) discounts.add(element);
      });
    }
    if (tab[index] == 'Store') {
      discounts = [];
      totalDiscounts.forEach((element) {
        if (element.isOffline) discounts.add(element);
      });
    }
    update();
  }
}
