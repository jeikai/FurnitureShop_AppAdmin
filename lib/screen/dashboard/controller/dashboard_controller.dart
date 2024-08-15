import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/dashboard.dart';
import 'package:furnitureshop_appadmin/data/repository/dashboard_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/order_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/product_store_repository.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:get/get.dart';

import 'package:furnitureshop_appadmin/data/models/order.dart' as MyOrder;

class DashBoardController extends GetxController {
  List<ChartData> chartData = [
    // ChartData('Give Away', 22.21, Color.fromARGB(255, 175, 215, 247)),
    // ChartData('Affiliate', 25.32, Color.fromARGB(255, 210, 183, 215)),
    ChartData('Offline Sale', 60, Color.fromARGB(255, 239, 180, 199)),
    ChartData('Online Sale', 50, Color.fromARGB(255, 175, 215, 247)),
  ];
  List<PricePoint> points = [
    PricePoint(x: 20, y: 3.0),
    PricePoint(x: 10, y: 4.0),
    PricePoint(x: 12, y: 2.0),
    PricePoint(x: 5, y: 1.0),
    PricePoint(x: 7, y: 5.0),
    PricePoint(x: 8, y: 6.0),
    PricePoint(x: 2, y: 7.0),
  ];
  List<double> userOrderInWeek = [
    8,
    10,
    14,
    15,
    50,
    10,
    16,
    53
  ];
  MyDashBoard db_ = MyDashBoard(totalProfit: 193.56);
  List<MyDashBoard> recentSale_ = [
    MyDashBoard(
      avt: 'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Fdining_suites%2FEvQjv1t56s0iT9I%2Freceived_1251690672152773.webp?alt=media&token=c265fecf-4ffb-4d3e-99d4-66346f8901e3',
      name: 'Nguyen Van A',
      money: 125.44,
      time: '10',
    ),
    MyDashBoard(
      avt: 'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Fdining_suites%2FEvQjv1t56s0iT9I%2Freceived_1251690672152773.webp?alt=media&token=c265fecf-4ffb-4d3e-99d4-66346f8901e3',
      name: 'Nguyen Van B',
      money: 315.12,
      time: '15',
    ),
    MyDashBoard(
      avt: 'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Fdining_suites%2FEvQjv1t56s0iT9I%2Freceived_1251690672152773.webp?alt=media&token=c265fecf-4ffb-4d3e-99d4-66346f8901e3',
      name: 'Nguyen Van C',
      money: 105.57,
      time: '20',
    ),
    MyDashBoard(
      avt: 'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Fdining_suites%2FEvQjv1t56s0iT9I%2Freceived_1251690672152773.webp?alt=media&token=c265fecf-4ffb-4d3e-99d4-66346f8901e3',
      name: 'Nguyen Van D',
      money: 223.45,
      time: '23',
    ),
  ];

  double productOffline = 49.61;
  double productOnline = 50.39;

  List<MyDashBoard> db = [
    MyDashBoard(
      month: 3,
      profit: 55.2,
      increasing_month: 25.12,
      color: Color.fromRGBO(210, 145, 188, 1),
      ava: 'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Fdining_suites%2FEvQjv1t56s0iT9I%2Freceived_1251690672152773.webp?alt=media&token=c265fecf-4ffb-4d3e-99d4-66346f8901e3',
      username: 'Burno Pham',
      totalPrice: 1000.55,
      totalProducts: 5,
      dateTime: '30/04/2023',
    ),
    MyDashBoard(
      month: 4,
      profit: 50.8,
      increasing_month: 24.12,
      color: Color.fromRGBO(224, 187, 228, 1),
      ava: 'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Fdining_suites%2FjzSgJbMiRTWrbFz%2Freceived_251608030663698.webp?alt=media&token=29a952aa-579c-4790-bb00-a959d1eb49d2',
      username: 'Trong Nhan',
      totalPrice: 699.0,
      totalProducts: 1,
      dateTime: '02/01/2023',
    ),
    MyDashBoard(
      month: 5,
      profit: 57.8,
      increasing_month: 22.12,
      color: Color.fromRGBO(254, 200, 216, 1),
      ava: 'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Fdouble_bed%2F4bATcHDpNnfDMt3%2Freceived_3391335521084819.webp?alt=media&token=1a351d74-6fb3-4172-828f-e660c79d0623',
      username: 'Duc Quynh',
      totalPrice: 5000.00,
      totalProducts: 10,
      dateTime: '03/03/2023',
    ),
    MyDashBoard(
      month: 6,
      profit: 80.2,
      increasing_month: 29.12,
      color: Color.fromRGBO(255, 223, 211, 1),
      ava: 'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Fdouble_bed%2F8b7Dfc3RJkVhoAZ%2Freceived_940785973609906.webp?alt=media&token=a3f4c1f6-77c3-444d-854e-ea0af1e53663',
      username: 'Thu Hien',
      totalPrice: 1200.55,
      totalProducts: 7,
      dateTime: '01/04/2023',
    ),
  ];
  var selectedType = '1';
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Every 1 day"), value: "1"),
      DropdownMenuItem(child: Text("Every 3 days"), value: "2"),
      DropdownMenuItem(child: Text("Every 1 week"), value: "3"),
      DropdownMenuItem(child: Text("Every 1 monthly"), value: "4"),
    ];
    return menuItems;
  }

  @override
  void onInit() {
    super.onInit();
    loadTable1();
    loadTable2();
  }

  Future<void> loadTable1() async {
    List<Map<String, dynamic>> data = await DashboardRepository().table1();
    for (int i = 0; i < 4; i++) {
      db[i].month = data[i]['month'];
      db[i].totalPrice = data[i]['total'];
      db[i].profit = data[i]['percen'];
    }
    update();
    loadTable4();
  }

  Future<void> loadTable2() async {
    userOrderInWeek = await DashboardRepository().table2();
    update();
  }

  Future<void> loadTable4() async {
    double product_online = await ProductStoreRepository().getProductMonth();
    List<Map<String, dynamic>> data = await DashboardRepository().table1();
    double product_offline = data[0]['total'] ?? 1;
    chartData = [
      // ChartData('Give Away', 22.21, Color.fromARGB(255, 175, 215, 247)),
      // ChartData('Affiliate', 25.32, Color.fromARGB(255, 210, 183, 215)),
      ChartData('Offline Sale', product_offline, Color.fromARGB(255, 239, 180, 199)),
      ChartData('Online Sale', product_online, Color.fromARGB(255, 175, 215, 247)),
    ];
    db_ = MyDashBoard(totalProfit: product_offline + product_online);
    productOffline = product_offline / (product_offline + product_online) * 100;
    productOnline = 100 - productOffline;
    update();
  }

  Future<void> loadTable3() async {
    // List<MyOrder.Order> order = await OrderRepository().getOrdersMax();
    // int max = order.length > 4 ? 4 : order.length;
    // recentSale_ = [];
    // //  MyDashBoard(
    // //   avt: 'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Fdining_suites%2FEvQjv1t56s0iT9I%2Freceived_1251690672152773.webp?alt=media&token=c265fecf-4ffb-4d3e-99d4-66346f8901e3',
    // //   name: 'Nguyen Van A',
    // //   money: 125.44,
    // //   time: '10',
    // // ),
    // for (int i = 0; i < max; i++) {
    //   recentSale_.add(MyDashBoard(name:));
    // }
    update();
  }

  String format(int? i) {
    if (i == 1) return 'Jan';
    if (i == 2) return 'Feb';
    if (i == 3) return 'Mar';
    if (i == 4) return 'Apr';
    if (i == 5) return 'May';
    if (i == 6) return 'June';
    if (i == 7) return 'July';
    if (i == 8) return 'Aug';
    if (i == 9) return 'Sep';
    if (i == 10) return 'Oct';
    if (i == 11) return 'Nov';
    if (i == 12) return 'Dec';
    return '';
  }
}
