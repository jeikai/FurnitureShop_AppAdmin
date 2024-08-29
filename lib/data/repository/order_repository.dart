import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furnitureshop_appadmin/data/auth/auth_service.dart';
import 'package:furnitureshop_appadmin/data/models/guarantee.dart';
import 'package:furnitureshop_appadmin/data/models/notification.dart';
import 'package:furnitureshop_appadmin/data/models/order.dart' as MyOrder;
import 'package:furnitureshop_appadmin/data/models/order.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/models/request_order.dart';
import 'package:furnitureshop_appadmin/data/models/review.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';
import 'package:furnitureshop_appadmin/data/repository/guarantee_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/notification_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/product_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/review_repository.dart';
import 'package:furnitureshop_appadmin/data/servers/order_api_server.dart';
// import '../servers/order_api_server.dart';

class OrderRepository {
  OrderAPIServer orderAPIServer = OrderAPIServer();

  Future<void> addToOrder(MyOrder.Order order) async {
    order.userID = FirebaseAuth.instance.currentUser!.uid;
    await orderAPIServer.add(order.toMap());
  }

  Future<List<MyOrder.Order>> getOrderComplete() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('orders');
    List<MyOrder.Order> orders = [];

    await collection.get().then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyOrder.Order a = MyOrder.Order.fromMap(data, id: doc.id);
          if (statusOrderToString(a) == 'Completed') orders.add(a);
          return a;
        }
        return MyOrder.Order.empty();
      }).toList();
    });
    return orders;
  }

  Future<List<MyOrder.Order>> getOrders() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('orders');
    List<MyOrder.Order> orders = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      orders = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyOrder.Order a = MyOrder.Order.fromMap(data, id: doc.id);
          return a;
        }
        return MyOrder.Order.empty();
      }).toList();
    });
    return orders;
  }

  Future<List<int>> getOrderByWeekInMonth(DateTime month) async {
    CollectionReference orderCollection = FirebaseFirestore.instance.collection('orders');
    List<List<MyOrder.Order>> ordersByWeek = [];

    QuerySnapshot orderSnapshot = await orderCollection.get();
    for (var orderDoc in orderSnapshot.docs) {
      if (orderDoc.exists) {
        Map<String, dynamic> orderData = orderDoc.data() as Map<String, dynamic>;
        MyOrder.Order order = MyOrder.Order.fromMap(orderData, id: orderDoc.id);

        DateTime orderDate = this.orderDate(order);
        if (orderDate.year == month.year && orderDate.month == month.month) {
          int weekOfMonth = _weekOfMonth(orderDate);
          while (weekOfMonth >= ordersByWeek.length) {
            ordersByWeek.add([]);
          }
          ordersByWeek[weekOfMonth].add(order);
        }
      }
    }
    List<int> totalOrdersByWeek = ordersByWeek.map((orders) => orders.length).toList();
    return totalOrdersByWeek;
  }

  Future<List<MyOrder.Order>> getOrdersMax() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('orders');
    List<MyOrder.Order> orders = [];
    await collection.orderBy('priceTotal').get().then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyOrder.Order a = MyOrder.Order.fromMap(data, id: doc.id);
          if (statusOrderToString(a) == 'Completed') orders.add(a);
          return a;
        }
        return MyOrder.Order.empty();
      }).toList();
    });
    return orders;
  }

  Future<List<MyOrder.Order>> getOrdersRecently(DateTime dateTime) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('orders');
    CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    List<MyOrder.Order> orders = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyOrder.Order a = MyOrder.Order.fromMap(data, id: doc.id);
          if (statusOrderToString(a) == 'Completed' && orderDate(a).isAfter(dateTime)) orders.add(a);
          return a;
        }
        return MyOrder.Order.empty();
      }).toList();
    });
    return orders;
  }

  int _weekOfMonth(DateTime date) {
    int dayOfMonth = date.day;
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    int firstWeekday = firstDayOfMonth.weekday;
    return ((dayOfMonth + firstWeekday - 2) / 7).floor();
  }

  String statusOrderToString(MyOrder.Order order) {
    Map<int, String> value = {
      0: "Ordered",
      1: "Preparing",
      2: "Delivery",
      3: "Completed"
    };
    for (int i = 0; i < order.status.length; i++) {
      if (order.status[i].date == null) {
        return value[i - 1].toString();
      }
    }
    return "Completed";
  }

  int statusOrderToInt(MyOrder.Order order) {
    for (int i = 0; i < order.status.length; i++) {
      if (order.status[i].date == null) {
        return i;
      }
    }
    return 4;
  }

  DateTime orderDate(MyOrder.Order order) {
    for (int i = order.status.length - 1; i >= 0; i--) {
      if (order.status[i].date != null) {
        return order.status[i].date ?? DateTime.now();
      }
    }
    return DateTime.now();
  }

  Future<void> updateStatus(MyOrder.Order order, int index, UserProfile user) async {
    order.status[index].date = DateTime.now();
    List<StatusOrder> status = order.status as List<StatusOrder>;
    await orderAPIServer.update({
      'status': status.map((x) => x.toMap()).toList()
    }, order.id.toString());
    List<String> statusString = [
      "Ordered",
      "Preparing",
      "Delivery",
      "Complete"
    ];
    List<String> message = [
      "",
      "Your order has been confirmed. We will start preparing your order in the next few days.",
      "We have started shipping your order. You will receive your order in the next 5-7 days.",
      "The order has been delivered successfully. Please confirm receipt of the goods."
    ];
    MyNotiInformation noti = MyNotiInformation(
      userID: order.userID,
      adminID: AuthService.userId,
      orderId: order.id,
      orderStatus: statusString[index],
      message: message[index],
      createdAt: DateTime.now(),
    );
    await NotificationRepository().addNotification(noti);
    if (index == 3) {
      for (int i = 0; i < order.carts.length; i++) {
        Product product = await ProductRepository().getProduct(order.carts[i].idProduct);
        await ReviewRepository().addReview(
          Review(
            orderID: order.id.toString(),
            productID: product.id.toString(),
            product: product,
            userID: user.id,
            user: user,
          ),
        );
        await GuaranteeRepository().addGuarantee(
          Guarantee(
            orderID: order.id.toString(),
            productID: product.id.toString(),
            product: product,
            userID: user.id,
            user: user,
          ),
        );
      }
    }
  }
}
