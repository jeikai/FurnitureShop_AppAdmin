import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/order.dart';
import 'package:furnitureshop_appadmin/data/repository/request_order_repository.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/order_request_detail/controller/order_request_detail_controller.dart';
import 'package:get/get.dart';

import '../../../data/repository/order_repository.dart';
import '../../../data/values/colors.dart';
import '../../../data/values/fonts.dart';

class OrderRequestDetailPage extends GetView<OrderRequestDetailController> {
  const OrderRequestDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderRequestDetailController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: _appBar(),
              body: _bodyContent(context),
            ));
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          }),
      backgroundColor: backgroundColor,
      title: const Text(
        titleDetailsProduct,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _bodyContent(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(thickness: 5),
            Container(
              height: 30,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text(
                    controller.orders.id.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  // Text(
                  //   RequestOrderRepository()
                  //       .statusRequestOrderToString(controller.orders),
                  //   style: const TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w400,
                  //       color: Colors.red),
                  // ),
                ],
              ),
            ),
            const Divider(thickness: 5),
            _titleContent(titleName, controller.user.name.toString()),
            _titleContent(titleAddress, controller.orders.address.toString()),
            _titleContent(titleHotline, controller.orders.phone.toString()),
            _titleContent(
              titlePrice,
              controller.orders.priceOrder.toString(),
            ),
            _titleContent(titleNote, controller.orders.note.toString()),
            _date(),
            _imageContent(),
            const SizedBox(height: 50),
            _selectionButton(context),
          ],
        ),
      ),
    );
  }

  Widget _titleContent(String title, String content) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, top: 2),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              //const Divider(),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _date() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, top: 2),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: Get.height * 0.026,
                    width: Get.height * 0.174,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int itemIndex) {
                          return textDate(itemIndex, context);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Text textDate(int index, BuildContext context) {
    return Text(
      controller.orders.status[index].date.toString(),
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _imageContent() {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: const Text('Image'),
          ),
          _pictureContent(controller.orders.imagePath!.first.toString()),
        ],
      ),
    );
  }

  Container _pictureContent(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _attachPicture() {
    return SizedBox(
      height: 230,
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10), child: const Text('Attached image')),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _uploadImage(),
              SizedBox(width: Get.width - 105, child: SingleChildScrollView(child: showImage())),
            ],
          ),
        ],
      ),
    );
  }

  Widget _uploadImage() {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      child: SizedBox(
        width: 70,
        height: 70,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          child: Center(
            child: IconButton(
              iconSize: 20,
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.orange,
              ),
              onPressed: () {
                controller.selectedImage();
              },
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView showImage() {
    return SingleChildScrollView(
        child: Container(
      width: Get.width - 85,
      height: 174,
      // (controller.listImagePath.length / 4).ceil() * 85,
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: GridView.builder(
        itemCount: controller.listImagePath.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return _buildImage(index);
        },
      ),
    ));
  }

  Widget _buildImage(int index) {
    return Stack(
      children: [
        Image.file(File(controller.listImagePath[index]), height: 70, width: 70, fit: BoxFit.cover),
        Positioned(
          right: 13,
          top: 0,
          child: InkWell(
            child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(50)),
                child: const Icon(
                  Icons.clear,
                  size: 15,
                  color: Colors.red,
                )),
            onTap: () {
              controller.deleteImage(index);
            },
          ),
        )
      ],
    );
  }

  Widget _selectionButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                      margin: const EdgeInsets.all(10),
                      height: Get.height - 100,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Rejection reason:',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                          SizedBox(
                            height: 10,
                          ),
                          _textField(controller.reasonText, enter_reason, enter_reason_),
                          SizedBox(
                            height: 10,
                          ),
                          _attachPicture(),
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
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.all(7),
              width: Get.width * 0.45,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: buttonColor),
                color: WHITE,
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                cancel.toUpperCase(),
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
              width: Get.width * 0.45,
              color: buttonColor,
              padding: const EdgeInsets.all(12),
              child: Text(
                complete.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(TextEditingController controller, String? text, String hintT) {
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text ?? ''),
            TextField(
                controller: controller,
                cursorColor: textBlackColor,
                style: TextStyle(fontFamily: jose_fin_sans, fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: TextFieldColor)),
                  hintText: hintT,
                  hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w100, color: textGrey3Color),
                )),
          ],
        ));
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
                Text(
                  'Note:',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
              controller.noteText,
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
}
