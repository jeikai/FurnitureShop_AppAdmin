import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/review.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/management_review/controller/all_review_controller.dart';
import 'package:furnitureshop_appadmin/screen/reply_review/controller/reply_review_controller.dart';
import 'package:get/get.dart';

class ReplyReviewPage extends GetView<ReplyReviewController> {
  const ReplyReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllReviewController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: buildBody(controller.reviews),
            ));
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        'Reply Review',
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

  Widget buildBody(Review item) {
    return Container(
      child: Column(
        children: [
          reviewContent(item),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  replyReview(),
                  const SizedBox(height: 30),
                  if (controller.reviews.reply == null) replyBtn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container replyReview() {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Reply user's review",
            style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w800, fontSize: Get.width * 0.05, color: textBlackColor),
          ),
          Container(
              margin: const EdgeInsets.only(top: 20, right: 20),
              width: Get.width,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: WHITE,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: ColorShadow,
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: TextField(
                controller: controller.replyReviewController,
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.justify,
                maxLines: null,
                enabled: controller.reviews.reply == null,
                cursorColor: textBlackColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: controller.reviews.reply == null ? "Enter reply user's review ... " : controller.reviews.reply,
                  hintStyle: TextStyle(fontFamily: jose_fin_sans, fontSize: 14.5, fontWeight: FontWeight.w400, color: textGrey3Color),
                ),
              )),
        ],
      ),
    );
  }

  Widget reviewContent(Review item) {
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
                if (item.imagePath != null && item.imagePath!.length > 0) imageCustom(item),
                Container(
                  width: Get.width - 111,
                  margin: EdgeInsets.only(top: 5, left: 5),
                  child: Text(
                    item.content ?? "",
                    maxLines: 10,
                    style: TextStyle(fontSize: 18, fontFamily: nunito_sans, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container imageCustom(Review item) {
    return Container(
      height: 100,
      width: Get.width - 106,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: (item.imagePath ?? []).length,
          itemBuilder: (BuildContext context, int itemIndex) {
            return Container(
              height: 80,
              width: 80,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(item.imagePath?[itemIndex] ?? ""),
                fit: BoxFit.cover,
              )),
            );
          }),
    );
  }

  InkWell replyBtn() {
    return InkWell(
      onTap: () {
        controller.reply();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: Get.width,
        decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(10), boxShadow: const [
          BoxShadow(
            color: ColorShadow,
            blurRadius: 10,
            spreadRadius: 4,
          )
        ]),
        child: Text(
          controller.load ? "LOADING..." : 'REPLY',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Get.width * 0.051,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
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
