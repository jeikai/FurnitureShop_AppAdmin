import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/request_order.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/order_request/controller/order_request_controller.dart';
import 'package:furnitureshop_appadmin/screen/order_request_detail/view/order_requeset_detail_page.dart';
import 'package:furnitureshop_appadmin/data/repository/request_order_repository.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrderRequestPage extends GetView<OrderRequestController> {
  const OrderRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderRequestController>(
      builder: (value) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) => AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: Get.width / 3.2),
          child: Text(
            "Request Order",
            style: TextStyle(
              fontFamily: jose_fin_sans,
              color: Colors.black,
              fontSize: Get.width * 0.05,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          controller.tabCurrentIndex.value != 3
              ? buildPopupMenuButton(context)
              : Container(),
        ],
        backgroundColor: backgroundColor,
      );

  IconButton buildPopupMenuButton(BuildContext context) {
    final selectedTab = controller.tab[controller.tabCurrentIndex.value];

    return IconButton(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      onPressed: () {
        if (selectedTab == 'Ordered') {
          controller
              .showPopupMenu(['Transfer to preparing'], ['preparing'], context);
        }
        if (selectedTab == 'Preparing') {
          controller
              .showPopupMenu(['Transfer to delivered'], ['delivered'], context);
        }
        if (selectedTab == 'Delivery') {
          controller
              .showPopupMenu(['Transfer to completed'], ['completed'], context);
        }
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Checkbox(
                  value: controller.all,
                  activeColor: buttonColor,
                  side: const BorderSide(color: Colors.black),
                  onChanged: (value) {
                    controller.updateCheckPointAll();
                  },
                ),
                const Text(
                  'Select All',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Text(
                      sum_price,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 10),
                    Text (
                      '${controller.totalPrice.toStringAsFixed(2)} đ',
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(thickness: 5, color: WHITE),
          const SizedBox(height: 5),
          buildMenu(),
          const Divider(thickness: 5, color: WHITE),
          buildContent()
        ],
      ),
    );
  }

  Widget buildMenu() {
    return SizedBox(
      width: Get.width,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(controller.tab.length,
              (index) => buildItemTab(index, controller.tab[index])),
        ),
      ),
    );
  }

  InkWell buildItemTab(int index, String content) {
    return InkWell(
      onTap: () {
        if (index != controller.tabCurrentIndex.value) {
          controller.onChangePage(index);
        }
      },
      child: Column(
        children: [
          Text(
            content,
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: index == controller.tabCurrentIndex.value
                    ? Colors.black
                    : Colors.grey),
          ),
          index == controller.tabCurrentIndex.value
              ? Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                )
              : Container(),
        ],
      ),
    );
  }

  SizedBox buildContent() {
    return SizedBox(
      width: Get.width,
      height: Get.height - 270,
      child: controller.load
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.black,
              size: 30,
            ))
          : SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    return widgetCustom(controller.orders[index],
                        controller.users[index], index);
                  }),
            ),
    );
  }

  Widget widgetCustom(RequestOrder order, UserProfile user, int index) {
    return Column(
      children: [
        (controller.orders.length != null)
            ? Container(
                color: backgroundColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: Get.width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5),
                            height: 10,
                            width: 10,
                            child: Checkbox(
                              side: const BorderSide(color: Colors.black),
                              activeColor: buttonColor,
                              value: controller.check[index],
                              onChanged: (value) {
                                controller.updateCheckPoint(index);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            order.id.toString(),
                            style: TextStyle(
                              fontSize: Get.height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            RequestOrderRepository().statusOrderToString(order),
                            style: TextStyle(
                              fontSize: Get.height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Text(
                        'Customer name: ${controller.users[index].name}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Get.height * 0.02,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Customer phone: ${order.phone}',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: Get.height * 0.015,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Delivery address: ${order.address}',
                        style: TextStyle(
                          fontSize: Get.height * 0.015,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Divider(),
                      Center(
                        child: GestureDetector(
                          child: Text(
                            'Detail',
                            style: TextStyle(
                              fontSize: Get.height * 0.015,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            Get.to(const OrderRequestDetailPage(),
                                arguments: {'order': order, 'user': user});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Text(
                  "No orders yet",
                  style: TextStyle(
                      color: Colors.red, fontSize: 20, fontFamily: nunito_sans),
                ),
              ),
        SizedBox(
          height: Get.height * 0.015,
        ),
      ],
    );
  }
}
