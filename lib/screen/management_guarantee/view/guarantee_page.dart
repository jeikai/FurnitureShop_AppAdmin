// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:furnitureshop_appadmin/data/models/guarantee.dart';
import 'package:furnitureshop_appadmin/data/models/order.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/guarantee_details/view/guarantee_detail_page.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../controller/guarantee_controller.dart';

class GuarenteePage extends GetView<GuaranteeController> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GuarenteePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuaranteeController>(
      builder: (value) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          title: Padding(
            padding: EdgeInsets.only(left: Get.width / 2.8),
            child: Text(
              'Guarantee',
              style: TextStyle(
                  fontSize: Get.height * 0.025,
                  fontWeight: FontWeight.w500,
                  color: textBlackColor),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: textBlackColor,
              ),
            ),
          ],
        ),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          const Divider(height: 5, color: WHITE),
          buildMenu(),
          const Divider(height: 5, color: WHITE),
          Container(
            height: Get.height - 188,
            color: backgroundColor,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.guarantees.length,
                itemBuilder: (context, index) {
                  return widgetCustom(controller.guarantees[index]);
                }),
          ),
        ],
      ),
    );
  }

  Widget buildMenu() {
    return Container(
      width: Get.width,
      color: backgroundColor,
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

  Widget widgetCustom(Guarantee item) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(bottom: 20.0, top: 20, right: 16),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: ColorShadow,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: Get.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '02gLtVaQVuNa5N2fPyav',
                      style: TextStyle(
                        fontSize: Get.height * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Processing",
                      style: TextStyle(
                        fontSize: Get.height * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(item.product.imagePath![0]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: Get.width / 2,
                          margin: EdgeInsets.all(5),
                          child: Text(
                            item.product.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Get.height * 0.02,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            '\$${item.product.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: Get.height * 0.015,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5, top: 5),
                          child: Text(
                            item.user.name.toString() + ' - ' + "0968870407",
                            style: TextStyle(
                              fontSize: Get.height * 0.015,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5, top: 5),
                          child: Text(
                            "622 Trần Cao Vân, Đà Nẵng",
                            style: TextStyle(
                              fontSize: Get.height * 0.015,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    Get.to(const GuaranteeDetailPage());
                  },
                  child: Center(
                    child: Text(
                      detail,
                      style: TextStyle(
                        fontSize: Get.height * 0.015,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
