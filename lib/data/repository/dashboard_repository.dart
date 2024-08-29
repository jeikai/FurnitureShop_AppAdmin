import 'dart:developer';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furnitureshop_appadmin/data/models/order.dart' as MyOrder;
import 'package:furnitureshop_appadmin/data/repository/order_repository.dart';

class DashboardRepository {
  OrderRepository _orderRepository = OrderRepository();

  double totalPrice(List<MyOrder.Order> orders) {
    double totalPrice = 0;
    for (var order in orders) {
      totalPrice += order.priceOrder;
    }
    return totalPrice;
  }

  int lastMonth(int month, int n) {
    month -= n;
    return (month % 13 == 0) ? 12 : month;
  }

  int nextMonth(int month, int n) {
    month += n;
    return (month % 13 == 0) ? 1 : month;
  }

  double getTangTruongPercent(List<MyOrder.Order> lastMonthOrders, List<MyOrder.Order> thisMonthOrders) {
    if (lastMonthOrders.isEmpty || thisMonthOrders.isEmpty) return 0;
    return (totalPrice(thisMonthOrders) - totalPrice(lastMonthOrders)) / totalPrice(lastMonthOrders) * 100;
  }

  Future<List<Map<String, dynamic>>> table1() async {
    List<MyOrder.Order> orders = await _orderRepository.getOrderComplete();

    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month - 4;
    if (month < 1) {
      month += 12;
      year -= 1;
    }
    int day = 1;

    DateTime fourMonthDate = DateTime(year, month, day);
    List<MyOrder.Order> recentMonthsOrders = orders.where((order) {
      DateTime date = _orderRepository.orderDate(order);
      // log('${date.day}}/${date.month}/${date.year}');
      return date.compareTo(fourMonthDate) > 0;
    }).toList();

    List<MyOrder.Order> firstMonthOrders = [];
    List<MyOrder.Order> secondMonthOrders = [];
    List<MyOrder.Order> thirdMonthOrders = [];
    List<MyOrder.Order> fourthMonthOrders = [];
    List<MyOrder.Order> fifthMonthOrders = [];

    for (var order in recentMonthsOrders) {
      DateTime date = _orderRepository.orderDate(order);
      if (date.month == month) {
        firstMonthOrders.add(order);
      } else if (date.month == nextMonth(month, 1)) {
        secondMonthOrders.add(order);
      } else if (date.month == nextMonth(month, 2)) {
        thirdMonthOrders.add(order);
      } else if (date.month == nextMonth(month, 3)) {
        fourthMonthOrders.add(order);
      } else {
        fifthMonthOrders.add(order);
      }
    }

    final firstMonthData = {
      'month': nextMonth(month, 1),
      'total': totalPrice(secondMonthOrders),
      'percen': getTangTruongPercent(firstMonthOrders, secondMonthOrders),
    };
    final secondMonthData = {
      'month': nextMonth(month, 2),
      'total': totalPrice(thirdMonthOrders),
      'percen': getTangTruongPercent(secondMonthOrders, thirdMonthOrders),
    };
    final thirdMonthData = {
      'month': nextMonth(month, 3),
      'total': totalPrice(fourthMonthOrders),
      'percen': getTangTruongPercent(thirdMonthOrders, fourthMonthOrders),
    };
    final fourthMonthData = {
      'month': nextMonth(month, 4),
      'total': totalPrice(fifthMonthOrders),
      'percen': getTangTruongPercent(fourthMonthOrders, fifthMonthOrders),
    };

    List<Map<String, dynamic>> data = [
      fourthMonthData,
      thirdMonthData,
      secondMonthData,
      firstMonthData,
    ];
    return data;
  }

  Future<List<double>> table2() async {
    int index = getIntThuNgay();
    List<double> map = [];
    map.addAll(List.filled(7, 0));
    int day = DateTime.now().day - index;
    DateTime now = DateTime.now();
    List<MyOrder.Order> order = await OrderRepository().getOrdersRecently(DateTime(now.year, now.month, day));
    for (int i = 0; i < order.length; i++) {
      int t = OrderRepository().orderDate(order[i]).day;
      int j = now.day - t;
      map[index - j] = map[index - j] + 1;
    }
    double max = 0;
    for (int i = 0; i < 7; i++) {
      if (map[i] > max) max = map[i];
    }
    max += 3;
    map.add(max);
    return map;
  }

  int getIntThuNgay() {
    String thuNgay = DateFormat('EEEE', 'en_US').format(DateTime.now());
    switch (thuNgay) {
      case 'Monday':
        return 0;
      case 'Tuesday':
        return 1;
      case 'Wednesday':
        return 2;
      case 'Thursday':
        return 3;
      case 'Friday':
        return 4;
      case 'Saturday':
        return 5;
      case 'Sunday':
        return 6;
    }
    return 0;
  }
}
