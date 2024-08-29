import 'base_api_server.dart';

class RequestOrderAPIServer {
  String oderUrl() => "request_order";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> add(Map<String, dynamic> data) async {
    await api.add(url: oderUrl(), data: data);
  }

  Future<void> update(Map<String, dynamic> data, String id) async {
    await api.update(url: oderUrl(), data: data, id: id);
  }
}
