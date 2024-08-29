import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/order.dart';
import 'package:furnitureshop_appadmin/data/models/request_order.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';
import 'package:furnitureshop_appadmin/data/repository/request_order_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/user_repository.dart';
import 'package:get/get.dart';

class OrderRequestController extends GetxController {
  List<String> tab = [
    'Ordered',
    'Preparing',
    'Delivery',
    'Completed',
    'Cancel'
  ];
  Rx<int> tabCurrentIndex = 0.obs;
  List<bool> check = [];
  bool all = false;
  int dem = 0;
  List<RequestOrder> totalOrder = [];
  List<RequestOrder> orders = [];
  List<UserProfile> users = [];
  bool load = true;
  double totalPrice = 0;

  @override
  void onInit() {
    super.onInit();
    loadTotalOrder();
  }

  void updateCheckPoint(int index) {
    check[index] = !check[index];
    if (check[index]) {
      dem = dem + 1;
    } else {
      dem = dem - 1;
    }
    if (!check[index] && check[index] != all) {
      all = check[index];
    } else if (dem == totalOrder.length) {
      all = true;
    }
    update();
  }

  void updateCheckPointAll() {
    all = !all;
    if (all) {
      dem = totalOrder.length;
    } else {
      dem = 0;
    }
    check = List.filled(totalOrder.length, all);
    update();
  }

  void onChangePage(int index) async {
    load = true;
    update();
    tabCurrentIndex.value = index;
    orders = [];
    for (int i = 0; i < totalOrder.length; i++) {
      if (RequestOrderRepository().statusRequestOrderToString(totalOrder[i]) ==
          index) {
        orders.add(totalOrder[i]);
        users.add(
            await UserRepository().getUserProfileWithID(totalOrder[i].userID!));
      }
    }
    check = List.filled(orders.length, false);
    load = false;
    update();
  }

  Future<void> loadTotalOrder({int numberPage = 0}) async {
    if (load == false) {
      load = true;
      update();
    }
    totalOrder = await RequestOrderRepository().getOrders();
    totalPrice = 0;
    for (int i = 0; i < totalOrder.length; i++) {
      if (RequestOrderRepository().statusOrderToString(totalOrder[i]) !=
          'Completed') {
        totalPrice += totalOrder[i].priceOrder!;
      }
    }
    onChangePage(numberPage);
  }

  void showPopupMenu(
      List<String> titles, List<String> values, BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset buttonPosition = button.localToGlobal(Offset.zero);

    final menuItems = List<PopupMenuEntry<String>>.generate(
      titles.length,
      (index) => PopupMenuItem(
        child: Text(titles[index]),
        value: values[index],
      ),
    );

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx + button.size.width,
        buttonPosition.dy,
        buttonPosition.dx +
            button.size.width +
            10, // Optional offset for spacing
        buttonPosition.dy + button.size.height,
      ),
      items: menuItems,
      elevation: 8,
    ).then((selectedValue) {
      if (selectedValue != null) {
        handleChooseMenu(selectedValue, context);
      }
    });
  }

  void handleChooseMenu(String value, BuildContext context) {
    int numberStatus = 0;
    String title = "";
    if (value == "preparing") {
      title = 'Are you sure you want to proceed with preparing?';
      numberStatus = 1;
    }
    if (value == "delivered") {
      title = 'Are you sure you want to proceed with delivered?';
      numberStatus = 2;
    }
    if (value == "completed") {
      title = 'Are you sure you want to proceed with completed?';
      numberStatus = 3;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Rx<bool> loadTransferStatus = false.obs;
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text(title),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                if (loadTransferStatus.value == false) Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: Obx(() =>
                    Text(loadTransferStatus.value ? 'Loading...' : 'Yes')),
                onPressed: () async {
                  if (loadTransferStatus.value == false) {
                    loadTransferStatus.value = true;
                    await changeStatusOrder(numberStatus);
                    await loadTotalOrder(numberPage: numberStatus - 1);
                    Navigator.of(context).pop();
                  }
                }),
          ],
        );
      },
    );
  }

  Future<void> changeStatusOrder(int numberStatus) async {
    for (int i = 0; i < check.length; i++)
      if (check[i]) {
        await RequestOrderRepository()
            .updateStatus(orders[i], numberStatus, users[i]);
      }
  }
}
