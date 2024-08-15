// ignore_for_file: camel_case_types

import 'dart:ui';

class mngProduct {
  String? name;
  double? price;
  int? amount;
  List<Color>? imageColorTheme;
  List<String>? imagePath;

  mngProduct({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.amount,
    required this.imageColorTheme,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'price': this.price,
      'image_path': this.imagePath,
      'amount': this.amount,
      'color': this.imageColorTheme,
    };
  }
}
