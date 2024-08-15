import 'dart:io';
import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/add_discount/controller/add_discount_controller.dart';
import 'package:get/get.dart';

class AddDiscountPage extends GetView<AddDiscountController> {
  const AddDiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDiscountController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: buildBody(),
            ));
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        add_dis,
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

  Widget buildBody() {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                selectedImage(),
                showImage(),
              ],
            ),
            SizedBox(height: Get.height * 0.013),
            textFieldCustom(discount_name, controller.nameDisController, enter_dis_name),
            textFieldCustom(dis, controller.percentController, enter_percent, inputType: TextInputType.number),
            textFieldSize(date_start, date_end, enter_start, enter_end, content1: controller.timeStartController, content2: controller.timeEndController, inputType: TextInputType.datetime),
            SizedBox(height: Get.height * 0.025),
            role(),
            if (controller.selected == 2) textFieldCustom(discount_code, controller.codeController, enter_dis_code),
            if (controller.selected == 1) textFieldCustom(discount_score, controller.scoreController, enter_dis_score, inputType: TextInputType.number),
            textFieldSize(condition, limit, price_start, price_limts, content1: controller.priceStart, content2: controller.priceLimit, inputType: TextInputType.number),
            SizedBox(height: Get.height * 0.025),
            textFieldCustom(number, controller.number, enter_number),
            SizedBox(height: Get.height * 0.028),
            btnAdd(add_dis.toUpperCase()),
            SizedBox(height: Get.height * 0.018)
          ],
        ),
      ),
    );
  }

  Widget role() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Role',
          style: TextStyle(
            fontFamily: jose_fin_sans,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: controller.roles.length,
            itemBuilder: (context, index) {
              return buildRole(index);
            }),
      ]),
    );
  }

  Row buildRole(
    index,
  ) {
    return Row(children: [
      Theme(
          data: ThemeData(unselectedWidgetColor: bgRadio),
          child: Radio<int>(
            value: index,
            activeColor: buttonColor,
            groupValue: controller.selected,
            onChanged: (int? value) {
              controller.onSelected(value);
            },
          )),
      Text(controller.roles[index], style: TextStyle(fontFamily: 'JosefinSans', fontSize: Get.width * 0.045, fontWeight: FontWeight.w400, color: textBlackColor)),
    ]);
  }

  Column selectedImage() {
    return Column(
      children: [
        Text(
          'Image',
          style: TextStyle(fontFamily: jose_fin_sans, fontSize: Get.height * 0.024),
        ),
        SizedBox(height: Get.height * 0.026),
        Container(
          width: Get.height * 0.105,
          height: Get.height * 0.105,
          margin: EdgeInsets.only(left: Get.height * 0.026, bottom: Get.height * 0.013),
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: textBlackColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: () {
              controller.selectedImage();
            },
            child: const Icon(
              Icons.camera_alt,
              size: 40,
              color: buttonColor,
            ),
          ),
        ),
      ],
    );
  }

  Container showImage() {
    return Container(
      width: 85,
      height: 85,
      margin: const EdgeInsets.only(left: 20, top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    if (controller.imagePath == null) return Container();

    return Stack(
      children: [
        Image.file(File(controller.imagePath!), height: 85, width: 85, fit: BoxFit.cover),
        Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: WHITE,
                  ),
                  child: const Icon(
                    Icons.clear,
                    size: 20,
                  )),
              onTap: () {
                controller.deleteImage();
              },
            ))
      ],
    );
  }

  Widget textField(TextEditingController content, String hintText, TextInputType inputType) {
    return SizedBox(
      width: 130,
      //height: 30,

      child: TextField(
        keyboardType: inputType,
        controller: content,
        style: TextStyle(
          fontFamily: jose_fin_sans,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: buttonColor),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: jose_fin_sans,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget textFieldCustom(String title, TextEditingController content, String hintText, {IconButton? iconButton, TextInputType? inputType}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title.toString(),
            style: TextStyle(
              fontFamily: jose_fin_sans,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          TextField(
            controller: content,
            keyboardType: inputType,
            style: TextStyle(
              fontFamily: jose_fin_sans,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontSize: 20,
            ),
            cursorColor: textBlackColor,
            decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: buttonColor),
                ),
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 20,
                ),
                suffixIcon: iconButton),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget textFieldSize(String title1, String title2, String hintTitle1, String hintTitle2, {TextInputType inputType = TextInputType.text, required TextEditingController content1, required TextEditingController content2}) {
    return SizedBox(
      width: Get.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: TextStyle(
                    fontFamily: jose_fin_sans,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                textField(content1, hintTitle1, inputType),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title2,
                style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              textField(content2, hintTitle2, inputType),
            ],
          ),
        ],
      ),
    );
  }

  Widget btnAdd(String title) {
    return InkWell(
      onTap: () {
        if (controller.load == false) controller.addDiscount();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: Get.width,
        decoration: BoxDecoration(color: controller.load == false ? buttonColor : buttonColor.withOpacity(0.5), borderRadius: BorderRadius.circular(5), boxShadow: const [
          BoxShadow(
            color: ColorShadow,
            blurRadius: 10,
            spreadRadius: 4,
          )
        ]),
        child: Text(
          controller.load == false ? title : "Loading...",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: Get.width * 0.051, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
