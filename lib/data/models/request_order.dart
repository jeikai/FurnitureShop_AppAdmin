import 'dart:convert';
import 'package:furnitureshop_appadmin/data/models/order.dart';

class RequestOrder {
  String? id;
  String? userID;
  String? note;
  String? name;
  String? phone;
  String? address;
  double? priceOrder;
  List<String>? imagePath;
  List<StatusOrder> status;

  RequestOrder({this.id, this.address, this.phone, this.priceOrder, this.userID, this.imagePath, this.note, this.name, required this.status});

  factory RequestOrder.empty() {
    return RequestOrder(address: '', priceOrder: 0, note: '', id: '', imagePath: [], userID: '', phone: '', name: '', status: []);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'price_order': priceOrder,
      'userID': userID,
      'image_path': imagePath,
      'note': note,
      'phone': phone,
      'name': name,
      'id': id,
      'status': status.map((x) => x.toMap()).toList(),
    };
  }

  factory RequestOrder.fromMap(Map<String, dynamic> map, {String? id}) {
    return RequestOrder(
      id: id,
      address: map['address'] as String,
      priceOrder: map['price_order'] as double,
      userID: map['userID'] as String,
      phone: map['phone'] as String,
      imagePath: List<String>.from(map["image_path"]),
      note: map['note'] as String,
      name: map['name'] as String,
      status: List<StatusOrder>.from(
        (map['status'] as List<dynamic>).map<StatusOrder>(
          (x) => StatusOrder.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestOrder.fromJson(String source) => RequestOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, address: $address, price_order: $priceOrder, name: $name, phone: $phone, userID: $userID, image_path: $imagePath, note: $note,status: $status, )';
  }
}
