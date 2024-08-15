import 'package:furnitureshop_appadmin/data/servers/base_api_server.dart';

class NotificationAPIServer {
  String url(String id) => "/users/$id/notification";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> add(Map<String, dynamic> data) async {
    await api.add(url: url(data['userID']), data: data);
  }

  Future<void> update(Map<String, dynamic> data) async {
    await api.update(url: url(data['userID']), data: data, id: data['id']);
  }
}
