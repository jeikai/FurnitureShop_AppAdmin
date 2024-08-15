import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/discount.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/discount_detail/controller/discount_detail_controller.dart';
import 'package:get/get.dart';
import 'package:intl/src/intl/date_format.dart';
import '../../../data/values/images.dart';

class DiscountDetailPage extends GetView<DiscountDetailController> {
  const DiscountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscountDetailController>(
        builder: (value) => Scaffold(
              appBar: appBarCustom(),
              body: buildBody(),
            ));
  }

  Container buildBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      color: backgroundColor,
      child: SingleChildScrollView(
        child: buildItem(controller.discount),
      ),
    );
  }

  Column buildItem(MyDiscount discount) {
    return Column(children: [
      Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.174,
            child: Image.network(
              controller.discount.imageNetwork.toString(),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Get.height * 0.149, left: Get.height * 0.0124, right: Get.height * 0.0124),
            width: Get.width,
            child: _discount(),
          ),
          Container(
            alignment: Alignment.center,
            color: textGreenColor,
            margin: EdgeInsets.only(top: Get.height * 0.159, left: Get.height * 0.031, right: Get.height * 0.0124),
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
      Container(
        padding: EdgeInsets.only(top: Get.height * 0.026, left: Get.height * 0.026, right: Get.height * 0.026),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textTitleCustom(effective + ':'),
            _textCustom(' ${DateFormat('dd/MM/yyyy').format(controller.discount.timeStart ?? DateTime.now())} 00:00  -  ${DateFormat('dd/MM/yyyy').format(controller.discount.timeEnd ?? DateTime.now())}' + ' 23:59'),
            SizedBox(height: Get.height * 0.024),
            _textTitleCustom(offer + ':'),
            _textCustom('$offer1 Discount up to ' + controller.discount.percent.toString() + '%'),
            SizedBox(height: Get.height * 0.024),
            _textTitleCustom(apply + ':'),
            _textCustom(apply1),
            SizedBox(height: Get.height * 0.024),
            _textTitleCustom(condition + ':'),
            _textCustom(condition1 + 'Discount code ' + controller.discount.name.toString() + ' up to ' + controller.discount.percent.toString() + ' % off valid orders from ' + '\$ ${controller.discount.priceStart} - \$${controller.discount.priceLimit}' + ' on Amigo app.'),
            _textCustom('EXP:' + ' ${DateFormat('dd/MM/yyyy').format(controller.discount.timeStart ?? DateTime.now())} 00:00  -  ${DateFormat('dd/MM/yyyy').format(controller.discount.timeEnd ?? DateTime.now())}' + ' 23:59. Limited. Each customer is afraid to use only 1 time'),
            SizedBox(height: Get.height * 0.024),
            _textTitleCustom(paymentMt + ':'),
            _textCustom(paymentMt1),
            SizedBox(height: Get.height * 0.024),
            _textTitleCustom(number + ':'),
            _textCustom(controller.discount.number.toString()),
            SizedBox(height: Get.height * 0.024),
            if (controller.discount.isGame) _textTitleCustom('The number of game points to exchange:'),
            if (controller.discount.isGame) _textCustom(controller.discount.score.toString()),
            if (controller.discount.isOffline) _textTitleCustom('Code discount:'),
            if (controller.discount.isOffline) _textCustom(controller.discount.codeStore.toString()),
            SizedBox(height: Get.height * 0.024),
            _textTitleCustom(device),
            _textCustom(iOsAnd),
            SizedBox(height: Get.height * 0.024),
          ],
        ),
      ),
    ]);
  }

  Text _textTitleCustom(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Get.height * 0.02,
        color: Colors.black,
        fontFamily: jose_fin_sans,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _textCustom(String text) {
    return Text(
      '🔸' + text,
      style: TextStyle(
        fontSize: Get.height * 0.02,
        color: Colors.black,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        discount,
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
    );
  }

  Widget _discount() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: buttonColor,
          margin: EdgeInsets.only(bottom: Get.height * 0.005, top: Get.height * 0.005, right: Get.height * 0.025, left: Get.height * 0.025),
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
                        width: Get.height * 0.273,
                        child: Text(
                          controller.discount.name.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: Get.height * 0.025,
                            color: Colors.white,
                            fontFamily: jose_fin_sans,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Text(
                        'Effective : ${DateFormat('dd-MM-yyyy').format(controller.discount.timeStart ?? DateTime.now())}  -  ${DateFormat('dd-MM-yyyy').format(controller.discount.timeEnd ?? DateTime.now())}',
                        style: TextStyle(
                          fontSize: Get.height * 0.016,
                          color: Colors.white,
                          fontFamily: jose_fin_sans,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
