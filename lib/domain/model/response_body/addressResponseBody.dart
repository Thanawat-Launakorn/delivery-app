import 'package:flutter_application_1/domain/model/address/address.model.dart';

class AddressResponse {
  final int id;
  final String method;
  final String addressTitle;
  final String fullName;
  final String phone;
  final String zipCode;
  final String address;
  final int userId;

  AddressResponse(
      {required this.id,
      required this.method,
      required this.addressTitle,
      required this.address,
      required this.fullName,
      required this.phone,
      required this.userId,
      required this.zipCode});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'method': method,
      'addressTitle': addressTitle,
      'fullName': fullName,
      'phone': phone,
      'zipCode': zipCode,
      'address': address,
      'userId': userId
    };
  }

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
        id: json['id'],
        method: json['method'],
        addressTitle: json['addressTitle'],
        address: json['address'],
        fullName: json['fullName'],
        phone: json['phone'],
        userId: json['userId'],
        zipCode: json['zipCode']);
  }
}
