import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furnitureshop_appadmin/data/models/category.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/servers/product_api_server.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';

class ProductRepository {
  ProductAPIServer productAPIServer = ProductAPIServer();

  Future<void> addProduct(Product product, MyCategory category) async {
    Map<String, dynamic> data = product.toJson();
    data['search'] = getNameProductSearchArray(product, category.name ?? "");
    await productAPIServer.addProduct(data);
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('category').doc(category).collection('products');
    List<Product> products = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      products = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Product a = Product.fromJson(data, doc.id);
          return a;
        }
        return Product();
      }).toList();
    });
    return products;
  }

  Future<Product> getProduct(String productID) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('category').doc('all').collection('products');
    Product product = Product();
    await collection.doc(productID).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        product = Product.fromJson(data, productID);
      }
    });
    return product;
  }

  List<String> getNameProductSearchArray(Product product, String categoryName) {
    List<String> re = [];
    product.name = product.name ?? "";
    product.name = product.name!.trim();
    product.name = product.name!.replaceAll("  ", " ");
    if (product.name != "") {
      re = product.name!.toLowerCase().split(" ");
    }
    re.addAll(categoryName.toLowerCase().split(" "));
    return re;
  }

  Future<void> deleteProduct(Product product) async {
    if (product.id != null) {
      await productAPIServer.update({
        'id': product.id,
        'category': product.category,
        "is_deleted": Timestamp.now()
      }, product.id!);
      Fluttertoast.showToast(msg: "Deleted product successfully");
    }
  }

  Future<void> undoDeleteProduct(Product product) async {
    if (product.id != null) {
      await productAPIServer.update({
        'id': product.id,
        'category': product.category,
        "is_deleted": null
      }, product.id!);
      Fluttertoast.showToast(msg: "Undo deleted product successfully");
    }
  }

  Future<void> updateProduct(Product product, {String? link_ar, List<String>? listImage}) async {
    if (product.id != null) await productAPIServer.update(product.toJson(), product.id!, linkAR: link_ar, linkimage: listImage);
  }

  Future<void> setProduct(Product product) async {
    if (product.id != null) await productAPIServer.set(product.toJson(), product.id!);
  }
}
