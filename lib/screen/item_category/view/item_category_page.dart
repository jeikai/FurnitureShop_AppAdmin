import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/item_category/controller/item_category_controller.dart';
import 'package:get/get.dart';

class ItemCategoryPage extends GetView<ItemCategoryController> {
  const ItemCategoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemCategoryController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: buildBody(),
            ));
  }

  Container buildBody() {
    return Container(
        height: Get.height,
        padding: EdgeInsets.all(Get.height * 0.012),
        color: backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: Get.width,
                height: Get.height,
                child: GridView.builder(
                  itemCount: controller.menuIconPaths.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int i) {
                    return menuCategory(
                        i,
                        i == controller.currentIndex,
                        controller.menuIconPaths[i],
                        controller.menuIconPaths[i]);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      leading: SizedBox(
        height: Get.height * 0.01,
        width: Get.width * 0.01,
        child: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      title: Text(
        categories,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: Get.height * 0.018,
            fontFamily: jose_fin_sans),
      ),
    );
  }

  Widget menuCategory(
      int index, bool onSelected, String content, String iconPath) {
    return InkWell(
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.024),
          Container(
            height: Get.height * 0.075,
            width: Get.height * 0.075,
            padding: EdgeInsets.all(Get.height * 0.024),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(iconPath),
          ),
        ],
      ),
    );
  }
}
