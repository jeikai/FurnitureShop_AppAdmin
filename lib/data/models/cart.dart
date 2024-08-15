import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Cart {
  String id;
  String idProduct;
  double price;
  Color? color;
  double width;
  double height;
  double length;
  int amount;

  Cart({this.id = "", this.idProduct = "", this.price = 0, this.height = 0, this.width = 0, this.length = 0, this.amount = 1, this.color});

  Map<String, dynamic> toJson() {
    return {
      'id_product': this.idProduct,
      'price': this.price,
      'height': this.height,
      'width': this.width,
      'length': this.length,
      'amount': this.amount,
      'color': Cart().toStringFormat(this.color ?? Colors.black),
    };
  }

  factory Cart.fromJson(Map<String, dynamic> data, {String id = ""}) {
    return Cart(
      id: id,
      idProduct: data["id_product"] ?? "",
      price: data["price"] ?? 0,
      height: data["height"] ?? 0,
      width: data["width"] ?? 0,
      length: data["length"] ?? 0,
      amount: data["amount"] ?? 0,
      color: Cart().fromString(data["color"]),
    );
  }

  Color fromString(String color) {
    Color t = HexColor(color);
    return t;
  }

  String toStringFormat(Color color) {
    String t = color.toString();
    t = t.replaceAll("MaterialColor(primary value: ", "");
    t = t.replaceAll("Color(0xff", "#");
    t = t.replaceAll(")", "");
    return t;
  }
}
