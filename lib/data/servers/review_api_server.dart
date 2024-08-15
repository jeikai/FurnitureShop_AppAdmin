import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/servers/base_api_server.dart';

class ReviewAPIServer {
  String url() => "reviews";
  String reviewProductUrl(String category, String productID) => "/category/$category/products/$productID/reviews";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> add(Map<String, dynamic> data) async {
    await api.add(url: url(), data: data);
  }

  Future<void> updateReview(Map<String, dynamic> data, String id, Product product) async {
    await api.update(
        url: url(),
        data: {
          'reply': data['reply'],
          'adminID': data['adminID'],
        },
        id: id);
    if (product.category != null && product.id != null) {
      await api.update(
          url: reviewProductUrl(product.category!, product.id!),
          data: {
            'reply': data['reply'],
            'adminID': data['adminID'],
          },
          id: id);
    }
  }
}
