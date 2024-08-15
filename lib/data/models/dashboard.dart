// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';

class MyDashBoard {
  int? month;
  double? profit;
  double? increasing_month;
  Color? color;
  double? increasing_week;
  //lastOrder
  String? ava;
  String? username;
  double? totalPrice;
  int? totalProducts;
  String? dateTime;
  double? totalProfit;
  //recentSale
  String? avt;
  String? name;
    String? time;
      double? money;




  MyDashBoard(
      {this.month,
      this.profit,
      this.increasing_month,
      this.increasing_week,
      this.color,
      this.ava,
      this.dateTime,
      this.totalPrice,
      this.totalProfit ,
      this.totalProducts,
      this.username,
      //recentSale
      this.avt,
      this.name,
      this.time,
      this.money,
      
      });

  // Map<String, dynamic> toJson() {
  //   return {
  //     "name": name,
  //     "path": path,
  //     "image_path": imagePath,
  //   };
  // }

  // factory MyDashBoard.fromJson(Map<String, dynamic> data, String? id) {
  //   return MyDashBoard(
  //     id: id,
  //     name: data["name"],
  //     path: data["path"],
  //     imagePath: data["image_path"],
  //   );
  // }
}

class PricePoint {
  int x;
  double y;
  PricePoint({
    this.x = 0,
    this.y = 0,
  });
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  String x;
  double y;
  Color color;
}
