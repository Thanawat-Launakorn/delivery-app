import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/domain/model/response_body/getAllCategoryResponseBody.dart';

class GetAllProductResponse {
  final int id;
  final String name;
  final String description;
  final int price;
  final String image;
  final int category_id;
  final GetAllCategoryResponse category;

  GetAllProductResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.category_id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'category_id': category_id
    };
  }

  factory GetAllProductResponse.fromJson(Map<String, dynamic> json) {
    return GetAllProductResponse(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      category_id: json['category_id'],
      description: json['description'],
      category: GetAllCategoryResponse.fromJson(json['category']),
    );
  }
}
