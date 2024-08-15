import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furnitureshop_appadmin/data/models/product_store.dart';
import 'package:furnitureshop_appadmin/data/servers/product_store_api_server.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';

class ProductStoreRepository {
  ProductStoreAPIServer productAPIServer = ProductStoreAPIServer();

  Future<void> addProductStore(ProductStore product) async {
    if (product.idProduct != null && product.idProduct != "" && product.imageColorTheme != null) {
      ProductStore? productStore = await getProductStoreBy(product.idProduct!, product.imageColorTheme!);
      if (productStore != null) {
        if (productStore.id != null) {
          product.number += productStore.number;
          Map<String, dynamic> data = product.toMap();
          await productAPIServer.setProduct(data, productStore.id!);
          Fluttertoast.showToast(msg: "Add product successfully");
        } else {
          Fluttertoast.showToast(msg: "ID product empty");
        }
      } else {
        Map<String, dynamic> data = product.toMap();
        await productAPIServer.addProduct(data);
        Fluttertoast.showToast(msg: "Add product successfully");
      }
    } else {
      Fluttertoast.showToast(msg: "Data add error");
    }
  }

  Future<bool> deletedProductStore(ProductStore product) async {
    if (product.idProduct != null && product.idProduct != "" && product.imageColorTheme != null) {
      ProductStore? productStore = await getProductStoreBy(product.idProduct!, product.imageColorTheme!);
      if (productStore != null) {
        if (productStore.id != null) {
          productStore.number -= product.number;
          if (productStore.number > 0) {
            await updateAmountProductStore(productStore.id!, productStore.number);
            return true;
          } else {
            Fluttertoast.showToast(msg: "Product hết hàng");
            return false;
          }
        } else {
          Fluttertoast.showToast(msg: "Product hết hàng");
          return false;
        }
      } else {
        Fluttertoast.showToast(msg: "Product hết hàng");
        return false;
      }
    }
    return false;
  }

  Future<List<ProductStore>> getProductsStore() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('product_store');
    List<ProductStore> products = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          ProductStore a = ProductStore.fromMap(data, id: doc.id);
          products.add(a);
          return a;
        }
        return ProductStore.empty();
      }).toList();
    });
    return products;
  }

  Future<double> getProductMonth() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('product_store');
    List<ProductStore> products = [];
    double total = 0;
    await collection.get().then((QuerySnapshot querySnapshot) {
      products = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          ProductStore a = ProductStore.fromMap(data, id: doc.id);
          total += a.price;
          return a;
        }
        return ProductStore.empty();
      }).toList();
    });
    return total;
  }

  Future<List<ProductStore>> getProductsStoreNotEmpty() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('product_store');
    List<ProductStore> products = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          ProductStore a = ProductStore.fromMap(data, id: doc.id);
          if (a.number > 0) products.add(a);
          return a;
        }
        return ProductStore.empty();
      }).toList();
    });
    return products;
  }

  Future<ProductStore?> getProductStoreBy(String productID, Color color) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('product_store');
    ProductStore? product;
    await collection.get().then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          ProductStore a = ProductStore.fromMap(data, id: doc.id);
          if (a.idProduct == productID && a.imageColorTheme == color) product = a;
          return a;
        }
        return ProductStore.empty();
      }).toList();
    });
    return product;
  }

  Future<void> updateAmountProductStore(String id, int amount) async {
    if (id != "") {
      await productAPIServer.updateProduct({
        'number': amount
      }, id);
    }
  }
}
