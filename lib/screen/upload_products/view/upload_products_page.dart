import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/upload_products/controller/upload_products_controller.dart';
import 'package:get/get.dart';

class UploadProductsPage extends GetView<UploadProductsController> {
  UploadProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UploadProductsController>(
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
        'Add Products',
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

  Widget buildBody(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            category(),
            const SizedBox(height: 20),
            selectedImage(),
            showImage(),
            const SizedBox(height: 10),
            textFieldCustom("Product Name", controller.nameController, 'Give item name'),
            textFieldCustom("Price(\$)", controller.priceController, 'Price of item', inputType: TextInputType.number),
            textFieldCustom(product_details, controller.productDetails, hint_product_details),
            textFieldCustom(caption, controller.caption, hint_caption),
            textFieldSize(),
            textFieldCustom("Add Colors", controller.colorController, 'Add colors',
                iconButton: IconButton(
                  onPressed: () {
                    chooseColor(context);
                  },
                  icon: const Icon(
                    Icons.palette,
                    size: 25,
                    color: buttonColor,
                  ),
                )),
            textFieldCustom(product_weight, controller.weight, hint_product_weight,
                inputType: TextInputType.number,
                iconButton: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.scale,
                    size: 25,
                    color: buttonColor,
                  ),
                )),
            upFileAR(),
            if (controller.files != null) ShowFile(),
            const Divider(),
            const SizedBox(height: 15),
            post(),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  Widget upFileAR() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          strokeWidth: 1.5,
          dashPattern: [
            4,
            3
          ],
          child: InkWell(
            onTap: () {
              controller.selectFile();
            },
            child: Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(children: [
                  const Icon(
                    Icons.file_upload_outlined,
                    size: 35,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: Get.width - 100,
                    child: Text(
                      "Upload File AR Products",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: jose_fin_sans, fontSize: 16),
                    ),
                  ),
                ])),
          )),
    );
  }

  Container ShowFile() {
    if (controller.files == null) return Container();
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          offset: Offset(0, 1),
          blurRadius: 3,
          spreadRadius: 2,
        )
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Name: ",
            style: TextStyle(fontSize: 14, color: textGrey1Color),
          ),
          Text(
            controller.files!.name,
            style: const TextStyle(fontSize: 13, color: textBlackColor),
          ),
          Row(
            children: [
              const Text(
                "Size: ",
                style: TextStyle(fontSize: 14, color: textGrey1Color),
              ),
              Text(
                "${(controller.files!.size / 1024).ceil()} KB",
                style: const TextStyle(fontSize: 13, color: textBlackColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InkWell buttonUpload() {
    return InkWell(
      onTap: () {},
      child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: Get.width,
          decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(5), boxShadow: const [
            BoxShadow(
              color: ColorShadow,
              blurRadius: 10,
              spreadRadius: 4,
            )
          ]),
          child: Text("Upload", textAlign: TextAlign.center, style: TextStyle(fontSize: Get.width * 0.051, fontWeight: FontWeight.w600, color: Colors.white))),
    );
  }

  Widget category() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 22, bottom: 15),
          child: Text(
            "Category",
            style: TextStyle(fontFamily: jose_fin_sans, fontSize: 18),
          ),
        ),
        SizedBox(
          width: Get.width,
          height: controller.menu.length < 4 ? 100 : 210,
          child: GridView.builder(
            itemCount: controller.menu.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 0, mainAxisSpacing: 0),
            itemBuilder: (BuildContext context, int i) {
              return menuCategory(i, i == controller.currentIndexMenu, controller.menu[i].name.toString(), controller.menu[i].imagePath.toString());
            },
          ),
        ),
      ],
    );
  }

  Widget menuCategory(int index, bool onSelected, String content, String iconPath) {
    return InkWell(
      onTap: () {
        if (onSelected == false) {
          controller.onSeletedMenu(index);
        }
      },
      child: Column(
        children: [
          Container(
            height: Get.height * 0.08,
            width: Get.height * 0.08,
            padding: EdgeInsets.all(Get.height * 0.02),
            decoration: BoxDecoration(color: onSelected ? const Color.fromRGBO(250, 202, 123, 1) : Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
            child: Image.asset(iconPath),
          ),
          SizedBox(height: Get.height * 0.012),
          Text(content, style: TextStyle(fontFamily: jose_fin_sans, color: onSelected ? textBlackColor : textGrey1Color)),
        ],
      ),
    );
  }

  Column selectedImage() {
    return Column(
      children: [
        Text(
          'Image',
          style: TextStyle(fontFamily: jose_fin_sans, fontSize: 18),
        ),
        const SizedBox(height: 20),
        Container(
          width: 80,
          height: 80,
          margin: const EdgeInsets.only(left: 20, bottom: 10),
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

  SingleChildScrollView showImage() {
    return SingleChildScrollView(
        child: Container(
      width: Get.width,
      height: (controller.listImagePath.length / 4).ceil() * 85,
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listImagePath.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return _buildImage(index);
        },
      ),
    ));
  }

  Widget _buildImage(int index) {
    return Stack(
      children: [
        Image.file(File(controller.listImagePath[index]), height: 85, width: 85, fit: BoxFit.cover),
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
                controller.deleteImage(index);
              },
            ))
      ],
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

  Widget textField(
    TextEditingController content,
    String hintText,
  ) {
    return Container(
      width: 80,
      //height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.number,
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

  Widget textFieldSize() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Add size',
              style: TextStyle(
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textField(controller.widthController, 'width ...'),
              textField(controller.heightController, 'height ...'),
              textField(controller.lengthController, 'length ...'),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget post() {
    return InkWell(
      onTap: () {
        controller.post();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: Get.width,
        decoration: BoxDecoration(color: controller.load ? buttonColor.withOpacity(0.5) : buttonColor, borderRadius: BorderRadius.circular(5), boxShadow: const [
          BoxShadow(
            color: ColorShadow,
            blurRadius: 10,
            spreadRadius: 4,
          )
        ]),
        child: Text(
          controller.load ? "Loading ..." : "Post Now",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: Get.width * 0.051, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}

List<Color> pickColored = [];
void chooseColor(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Colors'),
          content: SingleChildScrollView(
            child: MultipleChoiceBlockPicker(
              pickerColors: pickColored,
              onColorsChanged: (List<Color> colors) {
                pickColored = colors;
              },
            ),
          ),
        );
      });
}
