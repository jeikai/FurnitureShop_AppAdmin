import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/product_store.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/management_category/controller/management_category_controller.dart';
import 'package:furnitureshop_appadmin/screen/management_product_store/controller/list_product_store_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ManagementProductStorePage extends GetView<ManagementProductStoreController> {
  ManagementProductStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagementCategoryController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: buildBody(context),
            ));
  }

  final Stream<QuerySnapshot> _roomStream = FirebaseFirestore.instance.collection('product_store').snapshots();
  Container buildBody(context) {
    return Container(
      height: Get.height,
      color: backgroundColor,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: StreamBuilder<QuerySnapshot>(
          stream: _roomStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('ERROR Steam product store: ${snapshot.hasError}');
              return Container();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.black,
                size: 30,
              ));
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                ProductStore product = ProductStore.fromMap(data, id: document.id);
                return buildItem(product, context);
              }).toList(),
            );
          }),
    );
  }

  Column buildItem(ProductStore product, BuildContext context) {
    return Column(
      children: [
        Container(
          height: Get.height * 0.075,
          margin: EdgeInsets.only(bottom: Get.height * 0.015, top: Get.height * 0.015),
          child: Row(
            children: [
              Container(
                height: Get.height * 0.075,
                width: Get.height * 0.075,
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                child: Image.network(
                  product.imagePath!.first.toString(),
                  fit: BoxFit.cover,
                  height: Get.height * 0.075,
                  width: Get.height * 0.075,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: Get.height * 0.124,
                  // width: Get.height * 0.261,
                  padding: EdgeInsets.symmetric(horizontal: Get.height * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Get.height * 0.016,
                          color: textGrey3Color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Price: ' + '\$${product.price.toString()}',
                        style: TextStyle(
                          fontSize: Get.height * 0.016,
                          color: textGrey3Color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Color: ',
                            style: TextStyle(
                              fontSize: Get.height * 0.016,
                              color: textGrey3Color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: product.imageColorTheme,
                            ),
                          )
                        ],
                      ),
                      Text(
                        'Amount: ${product.number}',
                        style: TextStyle(
                          fontSize: Get.height * 0.016,
                          color: textGrey3Color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    controller.amountEditting.text = product.number.toString();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            content: Container(
                              margin: const EdgeInsets.all(10),
                              width: Get.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Amount Product : '),
                                  TextField(
                                    controller: controller.amountEditting,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: Get.height * 0.024,
                                    ),
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: buttonColor),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  btnUpdate(product),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 18,
                  ))
            ],
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

  Widget btnUpdate(ProductStore productStore) {
    return InkWell(
      onTap: () {
        controller.updateAmountProductStore(productStore);
      },
      child: Container(
          alignment: Alignment.center,
          width: Get.width,
          height: Get.height * 0.059,
          decoration: const BoxDecoration(
            color: buttonColor,
          ),
          child: Text(btn_update.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontSize: Get.height * 0.019, fontWeight: FontWeight.w800, color: Colors.white))),
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        list_prod_store,
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
