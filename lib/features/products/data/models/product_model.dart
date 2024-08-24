import 'package:shopping_app/features/products/data/models/rating_model.dart';
import 'package:shopping_app/features/products/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: RatingModel.fromJson(json['rating']),
    );
  }

  static List<ProductModel> fromStringList(List<dynamic> stringList) {
    return stringList.map((string) => ProductModel.fromJson(string)).toList();
  }
}
