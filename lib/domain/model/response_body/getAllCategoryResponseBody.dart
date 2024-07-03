class GetAllCategoryResponse {
  final String id;
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
        id: json['id'],
        image: json['image'],
        category: json['category'],
        description: json['description']);
  }
}
