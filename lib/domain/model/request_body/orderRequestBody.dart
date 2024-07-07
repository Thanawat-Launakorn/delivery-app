class OrderRequest {
  final int userId;
  final int addressId;
  final List<Product> products;

  OrderRequest({
    required this.userId,
    required this.addressId,
    required this.products,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) {
    return OrderRequest(
      userId: json['userId'],
      addressId: json['addressId'],
      products: (json['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'addressId': addressId,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class Product {
  final int productId;
  final int quantity;

  Product({
    required this.productId,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
