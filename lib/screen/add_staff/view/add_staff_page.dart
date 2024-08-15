import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/add_staff/controller/add_staff_controller.dart';
import 'package:get/get.dart';

class AddStaffPage extends GetView<AddStaffController> {
  const AddStaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddStaffController>(
        builder: (value) => Scaffold(
              appBar: appBarCustom(),
              body: buildBody(),
            ));
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        add_staff,
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

  Container buildBody() {
    return Container(
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 10),
          textFieldCustom("Staff's name", controller.nameController, false, "Enter Staff's name ... ", inputType: TextInputType.name),
          const SizedBox(height: 20),
          textFieldCustom("Staff's email", controller.emailController, false, "Enter Staff's email ... ", inputType: TextInputType.emailAddress, suffixText: '@amigo.vn'),
          const SizedBox(height: 20),
          textFieldCustom("Staff's phone", controller.phoneController, false, "Enter Staff's phone ... ", inputType: TextInputType.phone, maxLength: 10),
          textFieldCustom("Employee code", controller.codeController, false, "Enter Employee code ... ",
              iconButton: controller.check == true
                  ? const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.report_gmailerrorred_outlined,
                        color: Colors.red,
                      ))
                  : const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.check_circle_outline_outlined,
                        color: textGreenColor,
                      )),
              maxLength: 10),
          Obx(
            () => textFieldCustom("Password", controller.passwordController, controller.isPasswordHidden.value, "Enter password ... ",
                inputType: TextInputType.visiblePassword,
                iconButton: IconButton(
                  icon: Icon(
                    controller.isPasswordHidden.value ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                    size: Get.height * 0.028,
                  ),
                  onPressed: () {
                    controller.isPasswordHidden.value = !controller.isPasswordHidden.value;
                  },
                ),
                maxLength: 12),
          ),
          role(),
          const SizedBox(height: 20),
          addButton()
        ]),
      ),
    );
  }

  Widget textFieldCustom(
    String title,
    TextEditingController content,
    bool obxCure,
    String hintText, {
    IconButton? iconButton,
    TextInputType? inputType,
    int? maxLength,
    String? suffixText,
  }) {
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
            obscureText: obxCure,
            controller: content,
            keyboardType: inputType,
            maxLength: maxLength,
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
                suffixText: suffixText,
                suffixStyle: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 20,
                ),
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 15,
                ),
                suffixIcon: iconButton),
          ),
        ],
      ),
    );
  }

  Widget role() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Role',
          style: TextStyle(
            fontFamily: jose_fin_sans,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: controller.roles.length,
            itemBuilder: (context, index) {
              return buildRole(index);
            }),
      ]),
    );
  }

  Row buildRole(
    index,
  ) {
    return Row(children: [
      Theme(
          data: ThemeData(unselectedWidgetColor: bgRadio),
          child: Radio<int>(
            value: index,
            activeColor: buttonColor,
            groupValue: controller.selected,
            onChanged: (int? value) {
              controller.onSelected(value);
            },
          )),
      Text(controller.roles[index], style: TextStyle(fontFamily: 'JosefinSans', fontSize: Get.width * 0.045, fontWeight: FontWeight.w400, color: textBlackColor)),
    ]);
  }

  Widget addButton() {
    return InkWell(
      onTap: () {
        controller.submitStaff();
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
          controller.load ? "Loading ..." : add_staff,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: Get.width * 0.051, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
