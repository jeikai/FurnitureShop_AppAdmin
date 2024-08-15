import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/order.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';
import 'package:furnitureshop_appadmin/data/repository/order_repository.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/list_orders/controller/list_order_controller.dart';
import 'package:furnitureshop_appadmin/screen/list_orders_detail/view/list_orders_detail_page.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ListOrderPage extends GetView<ListOrderController> {
  const ListOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListOrderController>(
      builder: (value) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) => AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: Get.width / 2.5),
          child: Text(
            titleAction,
            style: TextStyle(
              fontFamily: jose_fin_sans,
              color: Colors.black,
              fontSize: Get.width * 0.05,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: <Widget>[
          controller.tabCurrentIndex.value != 3 ? buildPopupMenuButton(context) : Container()
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
          controller.showPopupMenu([
            'Transfer to preparing'
          ], [
            'preparing'
          ], context);
        }
        if (selectedTab == 'Preparing') {
          controller.showPopupMenu([
            'Transfer to delivered'
          ], [
            'delivered'
          ], context);
        }
        if (selectedTab == 'Delivery') {
          controller.showPopupMenu([
            'Transfer to completed'
          ], [
            'completed'
          ], context);
        }
      },
    );
  }

  Widget _buildBody() {
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
                const SizedBox(width: 5),
                const Expanded(
                  child: Text(
                    'Total amount in advance',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                Text(
                  ': ${controller.totalPrice}đ',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(controller.tab.length, (index) => buildItemTab(index, controller.tab[index])),
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
            style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w600, fontSize: 16, color: index == controller.tabCurrentIndex.value ? Colors.black : Colors.grey),
          ),
          index == controller.tabCurrentIndex.value
              ? Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(50)),
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
                    return widgetCustom(controller.orders[index], controller.users[index], index);
                  }),
            ),
    );
  }

  Widget widgetCustom(Order order, UserProfile user, int index) {
    return Column(
      children: [
        Container(
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: Get.width * 0.04),
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
                      OrderRepository().statusOrderToString(order),
                      style: TextStyle(
                        fontSize: Get.height * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Text(
                  'Name customer: ${controller.users[index].name}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Get.height * 0.02,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  'Phone: ${order.address.phoneNumber}',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Get.height * 0.015,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  'Address shipping: ${order.address.fullAddress}',
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
                      Get.to(const ListOrderDetail(), arguments: {
                        'order': order,
                        'user': user
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.015,
        ),
      ],
    );
  }
}
