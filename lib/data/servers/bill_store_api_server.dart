import 'base_api_server.dart';

class BillStoreAPIServer {
  final String url = "/bill_store";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> setProduct(Map<String, dynamic> data, String id) async {
    await api.set(url: url, id: id, data: data);
  }

  Future<void> addProduct(Map<String, dynamic> data) async {
    await api.add(url: url, data: data);
  }
}
