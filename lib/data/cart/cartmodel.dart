import 'package:ecommerceapp/data/cart/cartproductentity.dart';

class CartModel extends CartProductEntity {
  CartModel({
    required super.name,
    required super.imageUrl,
    required super.size,
    required super.color,
    required super.price,
    required super.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      name: json['name'],
      imageUrl: json['imageUrl'],
      size: json['size'],
      color: json['color'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJSon() {
    return {
      "name": name,
      "imageUrl": imageUrl,
      "size": size,
      "color": color,
      "price": price,
      "quantity": quantity,
    };
  }
}
