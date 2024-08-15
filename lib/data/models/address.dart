import 'dart:convert';

class Address {
  String id;
  String receiver;
  String phoneNumber;
  String address;
  String provinceCode;
  String districtCode;
  String wardCode;
  String fullAddress;
  Address({
    required this.id,
    required this.receiver,
    required this.phoneNumber,
    required this.address,
    required this.provinceCode,
    required this.districtCode,
    required this.wardCode,
    required this.fullAddress,
  });

  Address copyWith({
    String? id,
    String? receiver,
    String? phoneNumber,
    String? address,
    String? provinceCode,
    String? districtCode,
    String? wardCode,
    String? fulladdress,
  }) {
    return Address(
      id: id ?? this.id,
      receiver: receiver ?? this.receiver,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      provinceCode: provinceCode ?? this.provinceCode,
      districtCode: districtCode ?? this.districtCode,
      wardCode: wardCode ?? this.wardCode,
      fullAddress: fulladdress ?? this.fullAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receiver': receiver,
      'phone_number': phoneNumber,
      'address': address,
      'province_code': provinceCode,
      'district_code': districtCode,
      'ward_code': wardCode,
      'full_address': fullAddress,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map, {String id = ""}) {
    return Address(
      id: id,
      receiver: map['receiver'] as String,
      phoneNumber: map['phone_number'] as String,
      address: map['address'] as String,
      provinceCode: map['province_code'] as String,
      districtCode: map['district_code'] as String,
      wardCode: map['ward_code'] as String,
      fullAddress: map['full_address'] as String,
    );
  }

  factory Address.template() {
    return Address(
      id: "id",
      receiver: 'receiver',
      phoneNumber: 'phone_number',
      address: 'address',
      provinceCode: 'province_code',
      districtCode: 'district_code',
      wardCode: 'ward_code',
      fullAddress: 'full_address',
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>, id: "");

  @override
  String toString() {
    return 'Address(receiver: $receiver, phoneNumber: $phoneNumber, address: $address, provinceCode: $provinceCode, districtCode: $districtCode, wardCode: $wardCode, fulladdress: $fullAddress)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.receiver == receiver && other.phoneNumber == phoneNumber && other.address == address && other.provinceCode == provinceCode && other.districtCode == districtCode && other.wardCode == wardCode && other.fullAddress == fullAddress;
  }

  @override
  int get hashCode {
    return receiver.hashCode ^ phoneNumber.hashCode ^ address.hashCode ^ provinceCode.hashCode ^ districtCode.hashCode ^ wardCode.hashCode ^ fullAddress.hashCode;
  }
}
