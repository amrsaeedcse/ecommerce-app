import 'package:ecommerceapp/data/product/productentinty.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.price,
    super.oldPrice,
    super.isPriceChanged = false,
    super.isNew = false,
    super.isTopSelling = false,
    required super.category,
    required super.gender,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      category: json['category'],
      gender: json['gender'],
      isTopSelling: json['isTopSelling'] ?? false,
      isNew: json['isNew'] ?? false,
      isPriceChanged: json['isPriceChanged'] ?? false,
      oldPrice: json['oldPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'oldPrice': oldPrice,
      'isPriceChanged': isPriceChanged,
      'isNew': isNew,
      'isTopSelling': isTopSelling,
      'category': category,
      'gender': gender,
    };
  }
}
