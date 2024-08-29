// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/cart.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/edit_product/view/edit_product_page.dart';
import 'package:furnitureshop_appadmin/screen/item_product/controller/item_product_controller.dart';
import 'package:get/get.dart';

import '../../add_product_store/controller/add_product_store_controller.dart';
import '../../add_product_store/view/add_product_store_page.dart';

enum _MenuValues {
  edit,
  add_hot,
  delete,
  add_store,
}

class ItemProductPage extends GetView<ItemProductController> {
  const ItemProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemProductController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: buildBody(context),
            ));
  }

  Container buildBody(context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: SingleChildScrollView(
          child: Column(
        children: List.generate(controller.products.length, (index) => buildItem(index, controller.products[index], context)),
      )),
    );
  }

  Column buildItem(int index, Product product, context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              _buildProductInfo(product),
              buildSetting(context, index, controller.products[index])
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSetting(context, int index, Product product) {
    return PopupMenuButton(
        iconSize: 20,
        itemBuilder: (context) => [
              const PopupMenuItem(
                value: _MenuValues.edit,
                child: Text('Edit Products'),
              ),
              PopupMenuItem(
                value: _MenuValues.add_hot,
                child: Text(product.isHot == true ? 'Delete Hot Products' : 'Add Hot Products'),
              ),
              PopupMenuItem(
                value: _MenuValues.delete,
                child: Text(product.isDeleted == null ? 'Delete Products' : 'Undo deleted Products'),
              ),
              const PopupMenuItem(
                value: _MenuValues.add_store,
                child: Text('Add Products in Store'),
              ),
            ],
        onSelected: (value) {
          switch (value) {
            case _MenuValues.edit:
              Get.to(EditProductPage(), arguments: {
                'product': product
              });
              break;
            case _MenuValues.add_hot:
              controller.updateHotProductWithId(index);
              break;
            case _MenuValues.delete:
              if (product.isDeleted == null)
                controller.deleteProductWithId(index);
              else
                controller.undoDeleteProductWithId(index);
              break;
            case _MenuValues.add_store:
              addToStore(context, product);
              //controller.deleteProductWithId(index);
              break;
          }
        });
  }

  InkWell _buildProductInfo(Product product) {
    return InkWell(
      onTap: () {
        //
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.width * 0.2,
            width: Get.width * 0.2,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: NetworkImage(
                      (product.imagePath != null && product.imagePath!.isNotEmpty)
                          ? product.imagePath![0]
                          : '',
                    ),
                    fit: BoxFit.cover)
            ),
          ),
          Container(
            width: Get.width * 0.8 - 80,
            padding: EdgeInsets.symmetric(horizontal: Get.height * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.name.toString(),
                  style: TextStyle(
                    fontSize: Get.height * 0.0198,
                    color: textGrey3Color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Price: \$ ${product.price.toString()}',
                  style: TextStyle(
                    fontSize: Get.height * 0.016,
                    color: textGrey3Color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future addToStore(context, Product product) {
    return showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(30),
            topStart: Radius.circular(30),
          ),
        ),
        builder: (context) => AddStoreOption(product: product));
    // Add
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        product,
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
      actions: [],
    );
  }
}
