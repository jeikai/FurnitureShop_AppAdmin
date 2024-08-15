import 'package:furnitureshop_appadmin/data/servers/base_api_server.dart';

class GuaranteeAPIServer {
  String url() => "guarantees";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> add(Map<String, dynamic> data) async {
    await api.add(url: url(), data: data);
  }
}
