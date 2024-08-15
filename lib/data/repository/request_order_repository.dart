import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furnitureshop_appadmin/data/auth/auth_service.dart';
import 'package:furnitureshop_appadmin/data/models/Order.dart';
import 'package:furnitureshop_appadmin/data/models/guarantee.dart';
import 'package:furnitureshop_appadmin/data/models/notification.dart';
// ignore: library_prefixes
import 'package:furnitureshop_appadmin/data/models/request_order.dart'
    as MyRequest;
import 'package:furnitureshop_appadmin/data/models/review.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';
import 'package:furnitureshop_appadmin/data/repository/guarantee_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/notification_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/review_repository.dart';
import 'package:furnitureshop_appadmin/data/servers/request_order_api_server.dart';

class RequestOrderRepository {
  Future<List<MyRequest.RequestOrder>> getOrders() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('request_order');
    List<MyRequest.RequestOrder> orders = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      orders = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyRequest.RequestOrder a =
              MyRequest.RequestOrder.fromMap(data, id: doc.id);
          return a;
        }
        return MyRequest.RequestOrder.empty();
      }).toList();
    });
    return orders;
  }

  int statusRequestOrderToString(MyRequest.RequestOrder order) {
    Map<int, String> value = {
      0: "Ordered",
      1: "Preparing",
      2: "Delivery",
      3: "Completed",
      4: "Cancel"
    };
    for (int i = 0; i < order.status.length; i++) {
      if (order.status[i].date == null) {
        return i - 1;
      }
    }
    return 4;
  }

  Future<void> updateStatus(
      MyRequest.RequestOrder order, int index, UserProfile user) async {
    order.status[index].date = DateTime.now();
    List<StatusOrder> status = order.status as List<StatusOrder>;
    await RequestOrderAPIServer().update(
        {'status': status.map((x) => x.toMap()).toList()}, order.id.toString());
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
      // for (int i = 0; i < order.carts.length; i++) {
      //   Product product = await ProductRepository().getProduct(order.carts[i].idProduct);
      //   await ReviewRepository().addReview(
      //     Review(
      //       orderID: order.id.toString(),
      //       productID: product.id.toString(),
      //       product: product,
      //       userID: user.id,
      //       user: user,
      //     ),
      //   );
      // await GuaranteeRepository().addGuarantee(
      //   Guarantee(
      //     orderID: order.id.toString(),
      //     productID: product.id.toString(),
      //     product: product,
      //     userID: user.id,
      //     user: user,
      //   ),
      // );
      //}
    }
  }
}
