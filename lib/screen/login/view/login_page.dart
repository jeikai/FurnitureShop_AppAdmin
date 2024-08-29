import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/images.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/login/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (value) => Scaffold(
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: _buildBody()),
      ),
    );
  }

  Widget _buildBody() => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.016),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Column(
                children: [
                  Center(
                    child: Row(
                      children: [
                        const Spacer(),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.height * 0.01),
                            child: Container(
                              height: Get.height * 0.001,
                              width: Get.width * 0.3,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.13,
                          width: Get.width * 0.13,
                          child: Image.asset(logoPageAuth),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.height * 0.01),
                            child: Container(
                              height: Get.height * 0.001,
                              width: Get.width * 0.3,
                              color: Colors.grey,
                              //margin: EdgeInsets.only(bottom: 30.0),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  SizedBox(
                    width: Get.width * 0.9,
                    child: Text(
                      titleLoginOne,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: textHeaderColor,
                        fontFamily: 'JosefinSans',
                        // ---TODO CHANGE FONT TEXT FINAL------------
                        fontSize: Get.width * 0.08,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  SizedBox(
                    width: Get.width * 0.9,
                    child: Text(
                      titleLoginTwo,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: buttonColor,
                        fontFamily: 'JosefinSans',
                        // ---TODO CHANGE FONT TEXT FINAL------------
                        fontSize: Get.width * 0.08,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  Container(
                    //color: Colors.orange,
                    margin: EdgeInsets.all(Get.width * 0.02),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(96, 96, 96, 0.2),
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: Offset(1, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.all(Get.width * 0.05),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.emailController,
                            decoration: const InputDecoration(
                              labelText: emailText,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Obx(
                            () => TextField(
                              controller: controller.passwordController,
                              obscureText: controller.isPasswordHidden.value,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  suffix: InkWell(
                                    child: Icon(
                                      controller.isPasswordHidden.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                      size: Get.height * 0.025,
                                    ),
                                    onTap: () {
                                      controller.isPasswordHidden.value =
                                          !controller.isPasswordHidden.value;
                                    },
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          // GestureDetector(
                          //   child: Text(
                          //     forgetPassword,
                          //     style: TextStyle(
                          //       fontFamily: 'JosefinSans',
                          //       // ---TODO CHANGE FONT TEXT FINAL------------
                          //       fontSize: Get.height * 0.018,
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //   ),
                          //   onTap: () {},
                          // ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 6,
                                    offset: Offset(1, 3), // Shadow position
                                  ),
                                ],
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    controller.login();
                                  },
                                  child: Container(
                                    width: Get.width * 0.5,
                                    height: Get.height * 0.05,
                                    padding: EdgeInsets.all(Get.height * 0.015),
                                    child: const Text(
                                      logIn,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily:
                                            'JosefinSans', // ---TODO CHANGE FONT TEXT FINAL------------
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          SizedBox(
                            height: Get.height * 0.06,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
