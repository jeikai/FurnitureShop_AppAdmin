import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/edit_product/controller/edit_product_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class EditProductPage extends GetView<EditProductController> {
  EditProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProductController>(
        builder: (value) =>
            Scaffold(appBar: appBarCustom(), body: buildBody(context)));
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        edit_pr,
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

  Widget buildBody(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Image',
                style: TextStyle(fontFamily: jose_fin_sans, fontSize: 18),
              ),
            ),
            selectedImage(),
            showImage(),
            textFieldCustom("Product Name", controller.nameController,
                controller.product.name.toString()),
            textFieldCustom("Price(\$)", controller.priceController,
                controller.product.price.toString(),
                inputType: TextInputType.number),
            textFieldCustom(product_details, controller.productDetails,
                controller.product.description.toString()),
            textFieldCustom(caption, controller.caption,
                controller.product.caption.toString()),
            textFieldSize(),
            customColor("Add Colors",
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
            textFieldCustom(product_weight, controller.weight,
                controller.product.weight.toString(),
                inputType: TextInputType.number,
                iconButton: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.scale,
                    size: 25,
                    color: buttonColor,
                  ),
                )),
            const SizedBox(height: 10),
            upFileAR(),
            const SizedBox(height: 10),
            (controller.files != null)
                ? showFile()
                : Container(
                    margin: EdgeInsets.only(
                        top: 20, left: Get.width / 2.6, bottom: 5),
                    child: const Text(
                      'No AR file yet',
                      style: TextStyle(fontSize: 15, color: Colors.red),
                    )),
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
          dashPattern: [4, 3],
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

  Widget showFile() {
    if (controller.files == null) return Container();
    return Slidable(
      key: ValueKey(controller.files!.name),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              controller.deleteFile();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 2,
            ),
          ],
        ),
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
      ),
    );
  }


  Row selectedImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
        Container(
          width: Get.width - 140,
          height: (controller.product.imagePath!.length / 2).ceil() * 120,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.image.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemBuilder: (BuildContext context, int index) {
              return Image.network(controller.image[index]);
            },
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
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return _buildImageFile(index);
        },
      ),
    ));
  }

  Widget _buildImageFile(int index) {
    return Stack(
      children: [
        Image.file(File(controller.listImagePath[index]),
            height: 100, width: 100, fit: BoxFit.cover),
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

  Widget textFieldCustom(
      String title, TextEditingController content, String hintText,
      {IconButton? iconButton, TextInputType? inputType}) {
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
              color: textBlack2Color,
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
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: buttonColor),
                ),
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: textGrey3Color,
                  fontSize: 15,
                ),
                suffixIcon: iconButton),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget customColor(String title,
      {IconButton? iconButton, TextInputType? inputType}) {
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
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                height: 30,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.pickColored.length,
                    itemBuilder: (BuildContext context, int itemIndex) {
                      return Container(
                        margin: const EdgeInsets.all(5),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //borderRadius: BorderRadius.circular(50),
                          color: controller.pickColored[itemIndex],
                        ),
                      );
                    }),
              )),
              Container(child: iconButton),
            ],
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
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
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
              textField(controller.widthController,
                  controller.product.width.toString()),
              textField(controller.heightController,
                  controller.product.height.toString()),
              textField(controller.lengthController,
                  controller.product.length.toString()),
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
        decoration: BoxDecoration(
            color: controller.load ? buttonColor.withOpacity(0.5) : buttonColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: ColorShadow,
                blurRadius: 10,
                spreadRadius: 4,
              )
            ]),
        child: Text(
          controller.load ? "Loading ..." : "Update",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: Get.width * 0.051,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
    );
  }

  void chooseColor(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Colors'),
            content: MultipleChoiceBlockPicker(
              pickerColors: controller.pickColored,
              onColorsChanged: (List<Color> colors) {
                controller.pickColored = colors;
                controller.update();
              },
            ),
          );
        });
  }
}
