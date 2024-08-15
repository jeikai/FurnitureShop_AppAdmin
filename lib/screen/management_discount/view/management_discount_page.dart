import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/discount.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/add_discount/view/add_discount_page.dart';
import 'package:furnitureshop_appadmin/screen/discount_detail/view/discount_detail_page.dart';
import 'package:furnitureshop_appadmin/screen/management_discount/controller/managemnet_discount_controller.dart';
import 'package:get/get.dart';
import '../../../data/values/images.dart';
import 'package:intl/intl.dart';

class ManagementDiscountPage extends GetView<ManagementDiscountController> {
  const ManagementDiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagementDiscountController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: _buildBody(),
            ));
  }

  Widget _buildBody() {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          const SizedBox(height: 5),
          buildMenu(),
          const Divider(thickness: 5, color: WHITE),
          const SizedBox(height: 5),
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
          children: List.generate(controller.tab.length, (index) => buildItemTab(index, controller.tab[index])),
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

  Container buildContent() {
    return Container(
      height: Get.height - 160,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(controller.discounts.length, (index) => buildItem(index, controller.discounts[index])),
      )),
    );
  }

  Column buildItem(int index, MyDiscount discount) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              color: buttonColor,
              margin: EdgeInsets.only(bottom: Get.height * 0.02, top: Get.height * 0.005, right: Get.height * 0.025, left: Get.height * 0.025),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(Get.height * 0.0124),
                        height: Get.height * 0.1,
                        width: Get.height * 0.1,
                        color: Colors.white,
                        child: Image.asset(dis20),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Get.height * 0.28,
                            child: Text(
                              discount.name.toString(),
                              overflow: TextOverflow.ellipsis,
                              //maxLines: 2,
                              style: TextStyle(
                                fontSize: Get.height * 0.025,
                                color: Colors.white,
                                fontFamily: jose_fin_sans,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Text(
                            'Effective : ${DateFormat('dd-MM-yyyy').format(discount.timeStart ?? DateTime.now())}  -  ${DateFormat('dd-MM-yyyy').format(discount.timeEnd ?? DateTime.now())}',
                            style: TextStyle(
                              fontSize: Get.height * 0.016,
                              color: Colors.white,
                              fontFamily: jose_fin_sans,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.012),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.height * 0.2,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const DiscountDetailPage(), arguments: {
                                    'discount': discount
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      view_detail,
                                      style: TextStyle(
                                        fontSize: Get.height * 0.014,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.navigate_next_rounded,
                                      color: Colors.white,
                                      size: Get.height * 0.019,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: textGreenColor,
              margin: EdgeInsets.only(
                  // top: Get.height * 0.19,
                  left: Get.height * 0.02,
                  right: Get.height * 0.0124),
              width: Get.height * 0.075,
              height: Get.height * 0.0187,
              child: Text(
                'Limited',
                style: TextStyle(
                  fontSize: Get.height * 0.015,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget btnAddDiscount() {
    return Container(
      height: 70,
      width: 70,
      margin: const EdgeInsets.only(bottom: 18),
      child: IconButton(
          onPressed: () {
            Get.to(const AddDiscountPage());
          },
          icon: Icon(
            Icons.add_card_rounded,
            size: Get.height * 0.047,
            color: textBlackColor,
          )),
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        management_dis,
        style: TextStyle(fontFamily: 'JosefinSans', fontWeight: FontWeight.w800, fontSize: Get.width * 0.045, color: textBlackColor),
      ),
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: textBlackColor,
        ),
      ),
      actions: [
        btnAddDiscount()
      ],
    );
  }
}
