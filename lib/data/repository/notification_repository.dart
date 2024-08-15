import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/notification.dart';
import 'package:furnitureshop_appadmin/data/servers/notification_api_server.dart';

class NotificationRepository {
  NotificationAPIServer productAPIServer = NotificationAPIServer();

  Future<void> addNotification(MyNotiInformation noti) async {
    Map<String, dynamic> data = noti.toMap();
    await productAPIServer.add(data);
  }
}
