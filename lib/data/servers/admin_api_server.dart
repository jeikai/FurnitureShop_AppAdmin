import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:furnitureshop_appadmin/data/servers/base_api_server.dart';

class AdminAPIServer {
  final String userURL = "/account_admin";

  static BaseAPIServer api = BaseAPIServer();

  Future<void> add(String id, Map<String, dynamic> data) async {
    await api.set(id: id, url: userURL, data: data);
  }
}
