import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/guarantee.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/guarantee_details/controller/guarantee_detail_controller.dart';
import 'package:get/get.dart';

class GuaranteeDetailPage extends GetView<GuaranteeDetailController> {
  const GuaranteeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuaranteeDetailController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: buildBody(context),
            ));
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        title_guarantee,
        style: TextStyle(
            fontFamily: 'JosefinSans',
            fontWeight: FontWeight.w800,
            fontSize: Get.width * 0.045,
            color: textBlackColor),
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

  Container buildBody(context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(child: buildContent(context)),
    );
  }

  Widget buildContent(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.guarantees.length,
              itemBuilder: (context, index) {
                return infoUser(controller.guarantees[index]);
              }),
          const SizedBox(height: 20),
          ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.guarantees.length,
              itemBuilder: (context, index) {
                return infoProducts(controller.guarantees[index]);
              }),
          const SizedBox(height: 20),
          image(),
          content(0),
          SizedBox(height: Get.height / 9),
          selectionButton(context),
        ],
      ),
    );
  }

  Container infoUser(Guarantee item) {
    return Container(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Information customers claiming warranty",
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontSize: 18,
                fontWeight: FontWeight.w800),
          ),
          Container(
            width: Get.width,
            margin: const EdgeInsets.only(top: 10),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(item.user.avatarPath.toString()),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        item.user.name.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: nunito_sans,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        '0968870407',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: nunito_sans,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: Get.width - 155,
                      child: Text(
                        'Address Buying',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: nunito_sans,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container infoProducts(Guarantee item) {
    return Container(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Warranty product information",
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontSize: 18,
                fontWeight: FontWeight.w800),
          ),
          Container(
            width: Get.width,
            margin: const EdgeInsets.only(top: 10),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
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
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        item.product.name.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: nunito_sans,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        '\$${item.product.price}',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: nunito_sans,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: Get.width - 155,
                      child: Text(
                        'Size: ${item.product.width} - ${item.product.height} - ${item.product.length}',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: nunito_sans,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: Get.width - 155,
                      child: Text(
                        'Colors: ',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: nunito_sans,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: Get.width - 155,
                      child: Text(
                        'Amount: ',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: nunito_sans,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container image() {
    return Container(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Defective product image",
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontSize: 18,
                fontWeight: FontWeight.w800),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.guarantees.length,
              itemBuilder: (context, index) {
                return showImage(controller.guarantees[index]);
              }),
        ],
      ),
    );
  }

  SingleChildScrollView showImage(Guarantee item) {
    return SingleChildScrollView(
        child: Container(
      width: Get.width,
      height: (item.imagePath!.length / 4).ceil() * 85,
      margin: const EdgeInsets.only(left: 10, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: item.imagePath!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(item.imagePath![index],
              height: 85, width: 85, fit: BoxFit.cover);
        },
      ),
    ));
  }

  Container content(index) {
    return Container(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Error customers encountered when using',
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontSize: 18,
                fontWeight: FontWeight.w800),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 15, top: 10),
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
                child: Text(
                  controller.guarantees[index].Error.toString(),
                  style: TextStyle(
                      fontFamily: jose_fin_sans,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget selectionButton(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                    margin: const EdgeInsets.all(10),
                    height: Get.height - 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Rejection reason:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 18.0,
                              width: 18.0,
                              child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                color: Colors.red,
                                icon: const Icon(Icons.clear, size: 18.0),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _textField(controller.reasonController, enter_reason,
                            enter_reason_),
                        const SizedBox(height: 10),
                        // _attachPicture(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            color: buttonColor,
                            padding: const EdgeInsets.all(12),
                            child: const Text(
                              'CONFIRM',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.all(7),
            width: Get.width * 0.4,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: buttonColor),
              color: WHITE,
            ),
            padding: const EdgeInsets.all(12),
            child: Text(
              cancel_guarantee.toUpperCase(),
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => _bottomSheet(context),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(7),
            width: Get.width * 0.4,
            color: buttonColor,
            padding: const EdgeInsets.all(12),
            child: Text(
              accept.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomSheet(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: Get.height - 100,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Note:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                SizedBox(
                  height: 18.0,
                  width: 18.0,
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.red,
                    icon: const Icon(Icons.clear, size: 18.0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            _textField(
              controller.noteController,
              null,
              'Enter note ...',
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: double.infinity,
                color: buttonColor,
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'CONFIRM',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _textField(
      TextEditingController controller, String? text, String hintT) {
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text ?? ''),
            TextField(
                controller: controller,
                cursorColor: textBlackColor,
                style: TextStyle(
                    fontFamily: jose_fin_sans,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: TextFieldColor)),
                  hintText: hintT,
                  hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      color: textGrey3Color),
                )),
          ],
        ));
  }
}
