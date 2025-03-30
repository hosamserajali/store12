import 'package:get/get.dart';

class ProductModel {
  final int id;
  final String name;
  final String image;
  final double price;
  final String category;
  final String description;
  RxInt quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    required this.description,
    int quantity = 1,
  }) : quantity = RxInt(quantity.clamp(1, 100)); 

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['title'] ?? 'Unknown Product',
      image: json['thumbnail']?.toString() ?? 'https://via.placeholder.com/150',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] ?? 'Other',
      description: json['description'] ?? 'No description available',
      quantity: (json['quantity'] as num?)?.toInt().clamp(1, 100) ?? 1,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'thumbnail': image,
      'price': price,
      'category': category,
      'description': description,
      'quantity': quantity.value, 
    };
  }
}
