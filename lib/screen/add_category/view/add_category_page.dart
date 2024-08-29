import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/add_category/controller/add_category_controller.dart';
import 'package:get/get.dart';

class AddCategoryPage extends GetView<AddCategoryController> {
  const AddCategoryPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCategoryController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: buildBody(),
            ));
  }

  Container buildBody() {
    return Container(
        padding:
            EdgeInsets.only(left: Get.height * 0.035, top: Get.height * 0.024),
        color: backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              textFieldCustom(
                  category_name, controller.categoryName, hint_category_name),
              Text(
                categories,
                style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: Get.height * 0.02,
                ),
              ),
              SizedBox(
                width: Get.width,
                height: 250,
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
              SizedBox(
                height: Get.height * 0.083,
              ),
              btnContinue(),
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
        category_title.toUpperCase(),
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: Get.height * 0.018,
            fontFamily: jose_fin_sans),
      ),
    );
  }

  Widget textFieldCustom(
      String title, TextEditingController content, String hintText) {
    return Column(
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
            fontSize: Get.height * 0.018,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: content,
            style: TextStyle(
              fontFamily: jose_fin_sans,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontSize: Get.height * 0.024,
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
                fontSize: Get.height * 0.024,
              ),
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.048),
      ],
    );
  }

  Widget menuCategory(
      int index, bool onSelected, String content, String iconPath) {
    return InkWell(
      onTap: () {
        if (onSelected == false) {
          controller.onSeletedMenu(index);
        }
      },
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.024),
          Expanded( // hoặc Flexible
            child: Container(
              height: Get.height * 0.075,
              width: Get.height * 0.075,
              padding: EdgeInsets.all(Get.height * 0.024),
              decoration: BoxDecoration(
                color: onSelected
                    ? const Color.fromRGBO(250, 202, 123, 1)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(iconPath),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnContinue() {
    return InkWell(
      onTap: () {
        
        controller.add();
      },
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: Get.height * 0.035),
          width: Get.width,
          height: Get.height * 0.059,
          decoration: const BoxDecoration(
            color: buttonColor,
          ),
          child: Text(continue_button.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontSize: Get.height * 0.019,
                  fontWeight: FontWeight.w800,
                  color: Colors.white))),
    );
  }
}
