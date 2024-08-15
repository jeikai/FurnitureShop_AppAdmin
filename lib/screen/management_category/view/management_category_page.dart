import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furnitureshop_appadmin/data/models/category.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/add_category/view/add_category_page.dart';
import 'package:furnitureshop_appadmin/screen/item_category/view/item_category_page.dart';
import 'package:furnitureshop_appadmin/screen/item_product/view/item_product_page.dart';
import 'package:furnitureshop_appadmin/screen/management_category/controller/management_category_controller.dart';
import 'package:get/get.dart';

class ManagementCategoryPage extends GetView<ManagementCategoryController> {
  const ManagementCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagementCategoryController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: buildBody(),
              floatingActionButton: btnAdd(),
            ));
  }

  Container buildBody() {
    return Container(
      height: Get.height,
      color: backgroundColor,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(controller.categorys.length, (index) => buildItem(controller.categorys[index])),
      )),
    );
  }

  Column buildItem(MyCategory category) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(const ItemProductPage(), arguments: {
              'category_path': category.path
            });
          },
          child: Container(
            height: Get.height * 0.075,
            margin: EdgeInsets.only(bottom: Get.height * 0.015, top: Get.height * 0.015),
            child: Row(
              children: [
                Container(
                  height: Get.height * 0.075,
                  width: Get.height * 0.075,
                  padding: EdgeInsets.all(Get.height * 0.024),
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    category.imagePath.toString(),
                  ),
                ),
                SizedBox(
                  width: Get.height * 0.012,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: Get.height * 0.124,
                  width: Get.height * 0.261,
                  padding: EdgeInsets.symmetric(horizontal: Get.height * 0.01),
                  child: Text(
                    category.name.toString(),
                    style: TextStyle(
                      fontSize: Get.height * 0.016,
                      color: textGrey3Color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: Get.height * 0.0012,
          width: Get.width - 16 * 2,
          color: const Color.fromRGBO(253, 233, 195, 1),
        )
      ],
    );
  }

  Widget btnAdd() {
    return Container(
      alignment: Alignment.bottomRight,
      child: IconButton(
          onPressed: () {
            Get.to(AddCategoryPage());
          },
          icon: Icon(
            Icons.library_add,
            size: Get.height * 0.057,
          )),
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        category,
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
}
