// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';

class Review {
  String? id;
  String orderID;
  String productID;
  Product product;
  String userID;
  UserProfile user;
  String? content;
  int? numberStart;
  List<String>? imagePath;
  String? reply;
  String? adminID;
  Review({
    this.id,
    required this.orderID,
    required this.productID,
    required this.product,
    required this.userID,
    required this.user,
    this.content,
    this.numberStart,
    this.imagePath,
    this.adminID,
    this.reply,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'productID': productID,
      'product': product.toJson(),
      'userID': userID,
      'user': user.toJson(),
      'content': content,
      'numberStart': numberStart,
      'imagePath': imagePath,
      'reply': this.reply,
      'adminID': this.adminID
    };
  }

  factory Review.fromMap(Map<String, dynamic> map, {String id = ""}) {
    return Review(
      id: id,
      orderID: map['orderID'] as String,
      productID: map['productID'] as String,
      product: Product.fromJson(map['product'] as Map<String, dynamic>, map['productID'] as String),
      userID: map['userID'] as String,
      user: UserProfile.fromJson(map['user'] as Map<String, dynamic>, map['userID'] as String),
      content: map['content'] != null ? map['content'] as String : null,
      numberStart: map['numberStart'] != null ? map['numberStart'] as int : null,
      imagePath: map['imagePath'] != null ? List<String>.from(map['imagePath']) : null,
      reply: map['reply'] != null ? map['reply'] as String : null,
      adminID: map['adminID'] != null ? map['adminID'] as String : null,
    );
  }

  factory Review.template() {
    return Review(
      id: '',
      orderID: '',
      productID: '',
      product: Product(),
      userID: "",
      user: UserProfile(),
      content: null,
      numberStart: null,
      imagePath: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Review(id: $id, orderID: $orderID, productID: $productID, product: $product, userID: $userID, user: $user, content: $content, numberStart: $numberStart)';
  }

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;

    return other.id == id && other.orderID == orderID && other.productID == productID && other.product == product && other.userID == userID && other.user == user && other.content == content && other.numberStart == numberStart;
  }

  @override
  int get hashCode {
    return id.hashCode ^ orderID.hashCode ^ productID.hashCode ^ product.hashCode ^ userID.hashCode ^ user.hashCode ^ content.hashCode ^ numberStart.hashCode;
  }
}
