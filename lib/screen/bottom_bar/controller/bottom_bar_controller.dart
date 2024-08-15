// ignore_for_file: non_constant_identifier_names, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furnitureshop_appadmin/data/paths/icon_path.dart';
import 'package:furnitureshop_appadmin/screen/dashboard/view/dashboard_page.dart';
import 'package:furnitureshop_appadmin/screen/management_guarantee/view/guarantee_page.dart';
import 'package:furnitureshop_appadmin/screen/order_request/view/order_requet_page.dart';
import 'package:furnitureshop_appadmin/screen/list_orders/view/list_order_page.dart';
import 'package:furnitureshop_appadmin/screen/profile/profile_page.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  List<String> icons_seleted_path = [];
  List<String> icons_path = [];
  Rx<int> indexCurren = 0.obs;

  @override
  void onInit() {
    super.onInit();
    icons_path = [
      icon_activity,
      icon_order,
      icon_require,
      icon_guarantee,
      icon_user
    ];
  }

  Widget getBody() {
    if (indexCurren.value == 0) return const DashBoardPage();
    if (indexCurren.value == 3) return GuarenteePage();
    if (indexCurren.value == 1) return const ListOrderPage();
    if (indexCurren.value == 2) return const OrderRequestPage();
    if (indexCurren.value == 4) return const ProfilePage();
    return Container();
  }

  void onChanged(int index) {
    if (index != indexCurren.value) {
      indexCurren.value = index;
      // update();
    }
  }

  Widget getIcon(int index) {
    return SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          icons_path[index],
          fit: BoxFit.contain,
          color: index == indexCurren.value ? Colors.black : Colors.grey,
        ));
  }
}
