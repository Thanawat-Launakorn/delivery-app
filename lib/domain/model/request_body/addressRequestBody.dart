class AddressRequest {
  final String method;
  final String addressTitle;
  final String fullName;
  final String phone;
  final String zipCode;
  final String address;
  final int userId;

  AddressRequest(
      {required this.method,
      required this.addressTitle,
      required this.fullName,
      required this.address,
      required this.phone,
      required this.userId,
      required this.zipCode});

  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'addressTitle': addressTitle,
      'fullName': fullName,
      'phone': phone,
      'zipCode': zipCode,
      'address': address,
      'userId': userId,
    };
  }

  factory AddressRequest.fromJson(Map<String, dynamic> json) {
    return AddressRequest(
        address: json['address'],
        method: json['method'],
        addressTitle: json['addressTitle'],
        fullName: json['fullName'],
        phone: json['phone'],
        userId: json['userId'],
        zipCode: json['zipCode']);
  }
}
