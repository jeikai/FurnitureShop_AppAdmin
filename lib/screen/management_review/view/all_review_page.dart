import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/review.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/management_review/controller/all_review_controller.dart';
import 'package:furnitureshop_appadmin/screen/reply_review/view/reply_review_page.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ManagementReviewPage extends GetView<AllReviewController> {
  const ManagementReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllReviewController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: controller.load
                  ? Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.black,
                      size: 30,
                    ))
                  : buildBody(),
            ));
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        title_review,
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
        InkWell(
          onTap: () {},
          child: const Icon(
            Icons.filter_alt_outlined,
            color: textBlackColor,
          ),
        ),
      ],
    );
  }

  Container buildBody() {
    return Container(
      width: Get.width,
      height: Get.height,
      child: controller.reviews.length == 0
          ? Text('Not review')
          : SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.reviews.length,
                  itemBuilder: (context, index) {
                    return buildItem(controller.reviews[index]);
                  }),
            ),
    );
  }

  Widget buildItem(Review item) {
    return Container(
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: NetworkImage(item.user.avatarPath.toString()),
                fit: BoxFit.fill,
              ),
              //shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontFamily: nunito_sans, fontWeight: FontWeight.w500),
                ),
                buildRatingStar(item.numberStart ?? 5),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    "${item.user.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontFamily: nunito_sans, fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.content ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18, fontFamily: nunito_sans, fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(ReplyReviewPage(), arguments: item);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(left: Get.width / 8),
                        decoration: BoxDecoration(border: Border.all(width: 2, color: item.reply == null ? Colors.green : textGrey), borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.reply,
                          color: item.reply == null ? Colors.green : textBlackColor,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildRatingStar(int starValue) {
    return Row(
        children: List.generate(
            5,
            (index) => Icon(
                  (index <= starValue - 1) ? Icons.star : Icons.star_border,
                  size: 20,
                  color: Colors.amberAccent,
                )));
  }
}
