import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furnitureshop_appadmin/data/models/discount.dart';
import 'package:furnitureshop_appadmin/data/servers/discount_api_server.dart';

class DiscountRepository {
  DiscountAPIServer discountAPIServer = DiscountAPIServer();

  Future<void> addDiscount(MyDiscount product) async {
    Map<String, dynamic> data = product.toJson();
    await discountAPIServer.addDiscount(data);
  }

  Future<List<MyDiscount>> getDiscounts() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('discount');
    List<MyDiscount> discounts = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      discounts = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyDiscount a = MyDiscount.fromJson(data, doc.id);
          return a;
        }
        return MyDiscount();
      }).toList();
    });
    return discounts;
  }

  Future<MyDiscount?> getDiscountOffline(String code) async {
    code = code.trim();
    if (code == '') return null;
    CollectionReference collection = FirebaseFirestore.instance.collection('discount');
    MyDiscount? discount;
    await collection.where('code_store', isEqualTo: code).get().then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyDiscount a = MyDiscount.fromJson(data, doc.id);
          discount = a;
          return a;
        }
        return MyDiscount();
      }).toList();
    });
    return discount;
  }
}
