import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furnitureshop_appadmin/data/auth/auth_service.dart';
import 'package:furnitureshop_appadmin/data/paths/icon_path.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/images.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/add_staff/view/add_staff_page.dart';
import 'package:furnitureshop_appadmin/screen/chat/chat_home/view/chat_home_page.dart';
import 'package:furnitureshop_appadmin/screen/management_category/view/management_category_page.dart';
import 'package:furnitureshop_appadmin/screen/management_discount/view/management_discount_page.dart';
import 'package:furnitureshop_appadmin/screen/management_product_store/view/list_product_store_page.dart';
import 'package:furnitureshop_appadmin/screen/management_review/view/all_review_page.dart';
import 'package:furnitureshop_appadmin/screen/password/change_password/change_password_page.dart';
import 'package:furnitureshop_appadmin/screen/profile/profile_controller.dart';
import 'package:furnitureshop_appadmin/screen/sale_product/view/sale_product_page.dart';
import 'package:furnitureshop_appadmin/screen/setting/view/setting_page.dart';
import 'package:furnitureshop_appadmin/screen/upload_products/view/upload_products_page.dart';
import 'package:get/get.dart';

import '../login/view/login_page.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (value) => Scaffold(
              appBar: appBarCustom(),
              body: buildBody(),
            ));
  }

  Container buildBody() {
    return Container(
        color: backgroundColor,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: Get.height * 0.03,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(avatar),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.ad.name.toString(),
                        style: TextStyle(
                            fontFamily: jose_fin_sans,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      Text(
                        controller.ad.email.toString(),
                        style: TextStyle(
                            fontFamily: jose_fin_sans,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: hintTextColor),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            cardProfile("Add Staff", "Management Staff", () {
              Get.to(() => const AddStaffPage());
            }),
            cardProfile(password, '', () {
              Get.to(() => const ChangePassword());
            }),
            cardProfile(category, sub_category, () {
              Get.to(() => const ManagementCategoryPage());
            }),
            cardProfile(product, sub_product, () {
              Get.to(() => UploadProductsPage());
            }),
            cardProfile(add_pr_store, sub_add_pr_store, () {
              Get.to(() => ManagementProductStorePage());
            }),
            cardProfile("Discount", "Management discount", () {
              Get.to(() => const ManagementDiscountPage());
            }),
            cardProfile("Review", "Management review", () {
              Get.to(() => const ManagementReviewPage());
            }),
            cardProfile("Sale Product", "", () {
              Get.to(const SaleProductPage(),
                  arguments: {'admin': controller.ad});
            }),
            cardProfile(setting, "", () {
              Get.to(() => const SettingPage(),
                  arguments: {'admin': controller.ad});
            }),
            buttonLogout(),
          ]),
        ));
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      actions: [
        SizedBox(
            height: Get.height * 0.01,
            width: Get.width * 0.1,
            child: IconButton(
                onPressed: () {
                  Get.to(ChatHomePage());
                },
                icon: SvgPicture.asset(
                  icon_chat,
                  fit: BoxFit.contain,
                  color: Colors.grey,
                ))),
      ],
      title: SizedBox(
        width: Get.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            profile,
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.black),
          ),
        ]),
      ),
    );
  }

  Widget cardProfile(String title, String subText, Function() onPressed) {
    return Container(
      width: Get.width * 4,
      height: Get.height * 0.11,
      child: Card(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 17),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toString(),
                style: TextStyle(
                    fontFamily: jose_fin_sans,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                subText.toString(),
                style: TextStyle(
                    fontFamily: jose_fin_sans,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: hintTextColor),
              ),
            ],
          ),
          trailing: SizedBox(
            height: Get.height * 0.11,
            child: InkWell(
                child: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                ),
                onTap: onPressed),
          ),
        ),
      ),
    );
  }

  InkWell buttonLogout() {
    return InkWell(
      onTap: () {
        AuthService.signOut();
        Get.back();
        Get.to(() => const LoginPage());
      },
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.only(
            bottom: 20, left: Get.width - 90, right: 20, top: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 7,
                blurRadius: 10,
              ),
            ]),
        child: SvgPicture.asset(
          icon_out,
          fit: BoxFit.scaleDown,
          color: Colors.grey,
        ),
      ),
    );
  }
}
