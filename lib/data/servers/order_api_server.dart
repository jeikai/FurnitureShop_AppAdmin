import 'package:firebase_auth/firebase_auth.dart';
import 'package:furnitureshop_appadmin/data/servers/base_api_server.dart';

class OrderAPIServer {
  String oderUrl() => "orders";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> add(Map<String, dynamic> data) async {
    await api.add(url: oderUrl(), data: data);
  }

  Future<void> update(Map<String, dynamic> data, String id) async {
    await api.update(url: oderUrl(), data: data, id: id);
  }
}
