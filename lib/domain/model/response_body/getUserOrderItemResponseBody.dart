class OrderResponse {
  final int id;
  final int userId;
  final int addressId;
  final String createdAt;
  final String updatedAt;

  OrderResponse({
    required this.id,
    required this.userId,
    required this.addressId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      id: json['id'],
      userId: json['user_id'],
      addressId: json['address_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class ProductResponse {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final int categoryId;

  ProductResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.categoryId,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
      categoryId: json['category_id'],
    );
  }
}

class OrderItemResponse {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final OrderResponse order;
  final ProductResponse product;

  OrderItemResponse({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.order,
    required this.product,
  });

  factory OrderItemResponse.fromJson(Map<String, dynamic> json) {
    return OrderItemResponse(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      order: OrderResponse.fromJson(json['order']),
      product: ProductResponse.fromJson(json['product']),
    );
  }
}

class GetAllOrderResponse {
  final List<OrderItemResponse> response;
  final int responseStatus;

  GetAllOrderResponse({
    required this.response,
    required this.responseStatus,
  });

  factory GetAllOrderResponse.fromJson(Map<String, dynamic> json) {
    List<OrderItemResponse> orderItems = [];
    if (json['response'] != null) {
      orderItems = List<OrderItemResponse>.from(
        json['response'].map((item) => OrderItemResponse.fromJson(item)),
      );
    }
    return GetAllOrderResponse(
      response: orderItems,
      responseStatus: json['response_status'],
    );
  }
}
