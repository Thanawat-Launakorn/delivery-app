import 'package:flutter_application_1/domain/model/response_body/addressResponseBody.dart';

class GetAllOrderResponse {
  final List<GetUserOrderResponse> response;

  GetAllOrderResponse({required this.response});

  factory GetAllOrderResponse.fromJson(List<dynamic> jsonList) {
    return GetAllOrderResponse(
      response:
          jsonList.map((json) => GetUserOrderResponse.fromJson(json)).toList(),
    );
  }
}

class GetUserOrderResponse {
  final int? id; // Make fields nullable if they can be null in the response
  final int? userId;
  final int? addressId;
  final String? createdAt;
  final String? updatedAt;
  final UserResponse? user;
  final AddressResponse? address;
  final List<OrderItemsResponse>? orderItems;

  GetUserOrderResponse({
    required this.id,
    required this.userId,
    required this.addressId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.address,
    required this.orderItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'address_id': addressId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user?.toJson(), // Handle nullable fields
      'address': address?.toJson(),
      'orderItems': orderItems?.map((item) => item.toJson()).toList(),
    };
  }

  factory GetUserOrderResponse.fromJson(Map<String, dynamic> json) {
    return GetUserOrderResponse(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      addressId: json['address_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      user: json['user'] != null
          ? UserResponse.fromJson(json['user'])
          : null,
      address: json['address'] != null
          ? AddressResponse.fromJson(json['address'])
          : null,
      orderItems: json['orderItems'] != null
          ? (json['orderItems'] as List<dynamic>)
              .map((item) => OrderItemsResponse.fromJson(item))
              .toList()
          : null,
    );
  }
}


class UserResponse {
  final int? userId;
  final String? email;
  final String? password;
  final String? role;
  final String? createdAt;
  final String? updatedAt;

  UserResponse({
    required this.userId,
    required this.email,
    required this.password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'password': password,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      userId: json['user_id'] as int?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class OrderItemsResponse {
  final int? id;
  final int? orderId;
  final int? productId;
  final int? quantity;

  OrderItemsResponse({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
    };
  }

  factory OrderItemsResponse.fromJson(Map<String, dynamic> json) {
    return OrderItemsResponse(
      id: json['id'] as int?,
      orderId: json['order_id'] as int?,
      productId: json['product_id'] as int?,
      quantity: json['quantity'] as int?,
    );
  }
}