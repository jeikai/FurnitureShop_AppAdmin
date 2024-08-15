import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/product_store.dart';

class BillStore {
  String? nameUser;
  String? phoneUser;
  String? address;
  String? codeDiscount;
  double? priceOrder;
  double? discount;
  double? totalPrice;
  List<ProductStore> products = [];
  DateTime? timeBuy;
  String? nameSeller;

  BillStore({
    this.address = '',
    this.codeDiscount = '',
    this.discount = 0.0,
    this.nameUser = '',
    this.nameSeller = '',
    this.phoneUser = '',
    this.priceOrder = 0.0,
    this.timeBuy,
    this.totalPrice = 0.0,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name_user': nameUser,
      'phone_user': phoneUser,
      'address': address,
      'code_discount': codeDiscount,
      'price_order': priceOrder,
      'discount': discount,
      'total_price': totalPrice,
      'time_buy': timeBuy,
      'name-seller': nameSeller,
      'products':
          List.generate(products.length, (index) => products[index].toMap())
    };
  }
}
