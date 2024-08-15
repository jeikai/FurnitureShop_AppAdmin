import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furnitureshop_appadmin/data/paths/icon_path.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/screen/up_file.dart/controller/up_file_controller.dart';
import 'package:get/get.dart';

class UpFilePage extends GetView<UpFileController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpFileController>(
        builder: (value) => Scaffold(
              appBar: buildAppBar(),
              body: buildBody(),
            ));
  }

  Container buildBody() {
    return Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            InkWell(
              onTap: () {
                controller.selectFile();
                print('a');
              },
              child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  strokeWidth: 1.5,
                  dashPattern: [4, 3],
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.file_upload_outlined,
                          size: 35,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: Get.width - 100,
                          child: Text(
                            "Drag & Drop or Choose file to up load",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: jose_fin_sans, fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "CVS or TXT",
                          style: TextStyle(
                              fontFamily: jose_fin_sans,
                              fontSize: 14,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  )),
            ),
            const SizedBox(height: 10),
            (controller.files.length > 0)
                ? Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected File',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ShowFile(),
                        ]),
                  )
                : Container(),
            buttonUpload(),
            const SizedBox(height: 10),
          ]),
        ));
  }

  Container ShowFile() {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 2,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              controller.files.length,
              (index) => Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ClipRRect(
                        //     borderRadius:
                        //         BorderRadius.circular(8),
                        //     child: Image.file(
                        //       controller.file_image!,
                        //       width: 70,
                        //     )),
                        const Text(
                          "Name: ",
                          style: TextStyle(fontSize: 14, color: textGrey1Color),
                        ),
                        Text(
                          controller.files[index].name,
                          style: const TextStyle(
                              fontSize: 13, color: textBlackColor),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Size: ",
                              style: TextStyle(
                                  fontSize: 14, color: textGrey1Color),
                            ),
                            Text(
                              "${(controller.files[index].size / 1024).ceil()} KB",
                              style: const TextStyle(
                                  fontSize: 13, color: textBlackColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
        ));
  }

  InkWell buttonUpload() {
    return InkWell(
      onTap: () {},
      child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: Get.width,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: ColorShadow,
                  blurRadius: 10,
                  spreadRadius: 4,
                )
              ]),
          child: Text("Upload",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Get.width * 0.051,
                  fontWeight: FontWeight.w600,
                  color: Colors.white))),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        "Add new file",
        style: TextStyle(fontFamily: jose_fin_sans, color: Colors.black),
      ),
      actions: const [
        Icon(
          Icons.close_rounded,
          color: Colors.black,
        ),
        SizedBox(width: 16)
      ],
    );
  }
}
