import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/password/forgot_password/forgot_password_page.dart';
import 'package:furnitureshop_appadmin/screen/password/notify_password/notify_password_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class NotifyPasswordPage extends GetView<NotifyPasswordController> {
  const NotifyPasswordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotifyPasswordController>(
        builder: (value) => Scaffold(
              appBar: appBarCustom(),
              body: Container(
                color: backgroundColor,
                child: buildBody(),
              ),
            ));
  }

  Widget buildBody() {
    return Container(
      color: backgroundColor,
      width: Get.width,
      height: Get.height,
      padding: EdgeInsets.only(
          top: Get.height * 0.2,
          left: Get.height * 0.02,
          right: Get.height * 0.02,
          bottom: Get.height * 0.2),
      child: Column(
        children: [
          Text(
            forgot_pw,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w900,
                fontSize: Get.height * 0.038,
                color: textBlackColor),
          ),
          SizedBox(height: Get.height * 0.038),
          Text(
            get_pw_success,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w400,
                fontSize: Get.height * 0.022,
                color: textBlackColor),
          ),
          SizedBox(height: Get.height * 0.038),
          addContinue(),
        ],
      ),
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      leading: SizedBox(
        height: Get.height * 0.01,
        width: Get.width * 0.01,
        child: IconButton(
            onPressed: () => Get.to(ForgotPasswordPage()),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget addContinue() {
    return InkWell(
      onTap: () {
        //Get.to(LoginPage());
      },
      child: Container(
          margin:
              const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 20),
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: Get.width,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: ColorShadow,
                  blurRadius: 10,
                  spreadRadius: 4,
                )
              ]),
          child: Text(next.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontSize: Get.width * 0.051,
                  fontWeight: FontWeight.w600,
                  color: Colors.white))),
    );
  }
}
