import 'package:furnitureshop_appadmin/data/servers/base_api_server.dart';

class ProductStoreAPIServer {
  final String url = "/product_store";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> setProduct(Map<String, dynamic> data, String id) async {
    await api.set(url: url, id: id, data: data);
  }

  Future<void> addProduct(Map<String, dynamic> data) async {
    await api.add(url: url, data: data);
  }

  Future<void> updateProduct(Map<String, dynamic> data, String id) async {
    await api.update(url: url, data: data, id: id);
  }
}
