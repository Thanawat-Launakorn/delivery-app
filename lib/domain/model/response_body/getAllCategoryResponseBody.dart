class GetAllCategoryResponse {
  final int id;
  final String image;
  final String category;
  final String description;

  GetAllCategoryResponse({
    required this.id,
    required this.image,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'category': category,
      'description': description
    };
  }

  factory GetAllCategoryResponse.fromJson(Map<String, dynamic> json) {
    return GetAllCategoryResponse(
        id: json['id'] as int,
        image: json['image'] as String,
        category: json['category'] as String,
        description: json['description'] as String);
  }
}
