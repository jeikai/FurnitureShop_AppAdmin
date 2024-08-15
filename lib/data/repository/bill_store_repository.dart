import 'package:furnitureshop_appadmin/data/models/bill.dart';
import 'package:furnitureshop_appadmin/data/repository/product_store_repository.dart';
import 'package:furnitureshop_appadmin/data/servers/bill_store_api_server.dart';

class BillStoreRepository {
  Future<void> addToBill(BillStore order) async {
    bool check = true;
    for (int i = 0; i < order.products.length; i++) {
      bool c = await ProductStoreRepository().deletedProductStore(order.products[i]);
      if (c == false) {
        check = false;
        return;
      }
    }
    if (check == true) await BillStoreAPIServer().addProduct(order.toMap());
  }
}
