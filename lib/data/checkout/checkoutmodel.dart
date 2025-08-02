import 'package:ecommerceapp/data/checkout/checkoutentity.dart';

class CheckOutModel extends CheckOutEntity {
  CheckOutModel({
    required super.time,
    required super.userId,
    required super.address,
    required super.cartModels,
    required super.price,
    required super.progress,
    required super.orderId,
  });

  factory CheckOutModel.fromJson(Map<String, dynamic> json) {
    return CheckOutModel(
      orderId: json['orderId'],
      progress: json['progress'],
      price: json['price'],
      time: json["time"],
      userId: json["userId"],
      address: json["address"],
      cartModels: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "time": time,
      "address": address,
      "userId": userId,
      "price": price,
      "orderId": orderId,
      "progress": progress,
    };
  }
}
