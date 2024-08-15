import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/details_products/controller/details_product_controller.dart';
import 'package:get/get.dart';

class DetailsProductPage extends GetView<DetailsProductController> {
  const DetailsProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        child: _bodyContent(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          }),
      backgroundColor: Colors.white,
      title: const Text(
        titleDetailsProduct,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _bodyContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Text(
                  controller.demo.id,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  controller.swapStatus(controller.demo.status),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 5,
          ),
          _titleContent(titleName, controller.demo.nameClient, false, false),
          _titleContent(titleAddress, controller.demo.address, false, false),
          _titleContent(titleHotline, controller.demo.hotline, false, false),
          _titleContent(
              titleProduct, controller.demo.nameProduct, false, false),
          _titleContent(
              titleDetails, controller.demo.detailContent, false, false),
          _titleContent(titleEstimateDelivery,
              controller.demo.estimatedTimeDelivery.toString(), false, false),
          _titleContent(titleEndDelivery,
              controller.demo.estimatedTimeDelivery.toString(), false, false),
          _titleContent(titleStartDelivery,
              controller.demo.estimatedTimeDelivery.toString(), false, false),
          _titleContent(
              titilePrice, controller.demo.price.toString(), true, false),
          _titleContent(titleGuarentee, '${controller.demo.dayGuarentee} Tháng',
              false, true),
          _imageContent(),
          const Divider(),
          _attachPicture(),
          const Divider(
            thickness: 5,
          ),
          Align(alignment: Alignment.bottomRight, child: _selectionButton()),
        ],
      ),
    );
  }

  Widget _titleContent(
      String title, String content, bool isCheckEdit, bool isCheckMonth) {
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
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  if (isCheckEdit == true)
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        iconSize: 20,
                        icon: const Icon(
                          Icons.drive_file_rename_outline,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          // ...
                        },
                      ),
                    ),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  if (isCheckMonth == true)
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        iconSize: 20,
                        icon: const Icon(Icons.expand_more),
                        onPressed: () {
                          // ...
                        },
                      ),
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

  Widget _imageContent() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            child: const Text('Hình ảnh'),
          ),
          Row(
            children: [
              _pictureContent(imagePathProduct),
              _pictureContent(imagePathProduct),
              _pictureContent(imagePathProduct),
            ],
          ),
        ],
      ),
    );
  }

  Widget _attachPicture() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.all(5),
              child: const Text('Hình ảnh đính kèm')),
          Row(
            children: [
              _uploadImage(),
              _pictureContent(imagePathProduct),
              _pictureContent(imagePathProduct),
              _pictureContent(imagePathProduct),
            ],
          ),
        ],
      ),
    );
  }

  Container _pictureContent(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.fill,
        ),
        //shape: BoxShape.circle,
      ),
    );
  }

  Widget _uploadImage() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 60,
        height: 60,
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
                // TODO Click Library Image.
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectionButton() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                width: Get.width * 0.42,
                padding: const EdgeInsets.all(12),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.orange)),
                child: Text(
                  cancel.toUpperCase(),
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                width: Get.width * 0.42,
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
      ),
    );
  }
}
