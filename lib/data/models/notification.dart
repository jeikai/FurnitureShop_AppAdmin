// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MyNotiInformation {
  String? id;
  String? userID;
  String? adminID;
  String? orderId;
  String? orderStatus;
  String? message;
  DateTime? createdAt;
  bool isSeemed;

  MyNotiInformation({
    this.id,
    this.userID,
    this.adminID,
    this.orderId,
    this.orderStatus,
    this.message,
    this.createdAt,
    this.isSeemed = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userID': userID,
      'adminID': adminID,
      'productID': orderId,
      'product_status': orderStatus,
      'message': message,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'is_seemed': isSeemed,
    };
  }

  factory MyNotiInformation.fromMap(Map<String, dynamic> map, {String id = ""}) {
    return MyNotiInformation(
      id: id,
      userID: map['userID'] != null ? map['userID'] as String : null,
      adminID: map['adminID'] != null ? map['adminID'] as String : null,
      orderId: map['productID'] != null ? map['productID'] as String : null,
      orderStatus: map['product_status'] != null ? map['product_status'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      createdAt: map['created_at'] != null ? DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int) : null,
      isSeemed: map['is_seemed'] as bool,
    );
  }
}
