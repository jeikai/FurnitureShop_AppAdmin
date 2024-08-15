import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/models/product_store.dart';
import 'package:furnitureshop_appadmin/data/repository/product_store_repository.dart';
import 'package:furnitureshop_appadmin/screen/add_product_store/view/add_product_store_page.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AddStoreOption extends StatefulWidget {
  Product product;
  int chooseColor = 0;
  Rx<bool> load = false.obs;

  AddStoreOption({Key? key, required this.product}) : super(key: key);

  @override
  State<AddStoreOption> createState() => AddStoreOptionState();

  Future<void> AddProductStore(TextEditingController amountEditting, BuildContext context) async {
    Fluttertoast.showToast(msg: "Waitting load... ");
    if (amountEditting.text == '') {
      Fluttertoast.showToast(msg: "Amount empty");
      return;
    }
    int number = int.parse(double.parse(amountEditting.text.toString()).toStringAsFixed(0));
    if (number == 0) {
      Fluttertoast.showToast(msg: "Amount empty");
      return;
    }
    ProductStore productStore = ProductStore(
      idProduct: product.id,
      name: product.name,
      price: product.price,
      imageColorTheme: product.imageColorTheme![chooseColor],
      imagePath: product.imagePath,
      width: product.width,
      height: product.height,
      length: product.length,
      category: product.category,
      description: product.description,
      caption: product.caption,
      weight: product.weight,
      search: product.search,
      linkAR: product.linkAR,
      number: number,
    );
    await ProductStoreRepository().addProductStore(productStore);
    Navigator.pop(context);
  }
}
