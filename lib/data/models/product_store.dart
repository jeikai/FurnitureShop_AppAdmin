// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductStore {
  String? id;
  String? idProduct;
  String? name;
  double price;
  Color? imageColorTheme;
  List<String>? imagePath;
  double width;
  double height;
  double length;
  String? category;
  String? description;
  String? caption;
  double weight;
  List<String>? search;
  String? linkAR;
  int number;
  ProductStore({
    this.id,
    this.idProduct,
    this.name,
    required this.price,
    this.imageColorTheme,
    this.imagePath,
    required this.width,
    required this.height,
    required this.length,
    this.category,
    this.description,
    this.caption,
    required this.weight,
    this.search,
    this.linkAR,
    this.number = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idProduct': idProduct,
      'name': name,
      'price': price,
      'imageColorTheme': toStringArray(),
      'imagePath': imagePath,
      'width': width,
      'height': height,
      'length': length,
      'category': category,
      'description': description,
      'caption': caption,
      'weight': weight,
      'search': search,
      'linkAR': linkAR,
      'number': number
    };
  }

  factory ProductStore.fromMap(Map<String, dynamic> map, {String id = ""}) {
    return ProductStore(
      id: id,
      idProduct: map['idProduct'] != null ? map['idProduct'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] as double,
      imageColorTheme: map["imageColorTheme"] != null ? fromString(map["imageColorTheme"]) : null,
      imagePath: map['imagePath'] != null ? List<String>.from(map['imagePath']) : null,
      width: map['width'] as double,
      height: map['height'] as double,
      length: map['length'] as double,
      category: map['category'] != null ? map['category'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      caption: map['caption'] != null ? map['caption'] as String : null,
      weight: map['weight'] as double,
      search: map['search'] != null ? List<String>.from(map['search']) : null,
      linkAR: map['linkAR'] != null ? map['linkAR'] as String : null,
      number: map['number'] != null ? map['number'] as int : 0,
    );
  }

  factory ProductStore.empty() {
    return ProductStore(
      height: 0,
      length: 0,
      price: 0,
      weight: 0,
      width: 0,
    );
  }

  String toStringArray() {
    String t = imageColorTheme.toString();
    t = t.replaceAll("Color(", "");
    t = t.replaceAll(")", "");
    t = t.replaceAll("Materialprimary value: ", "");
    return t;
  }

  static Color fromString(String colors) {
    Color t = HexColor(colors.replaceAll("0xff", "#"));
    return t;
  }
}
