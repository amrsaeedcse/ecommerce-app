import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/data/cart/cartmodel.dart';
import 'package:ecommerceapp/data/product/productmodel.dart';

abstract class CheckOutEntity {
  final String address;
  String orderId;
  final String userId;
  final Timestamp time;
  final double price;
  String progress;
  List<CartModel> cartModels;

  CheckOutEntity({
    required this.progress,
    required this.orderId,
    required this.price,
    required this.time,
    required this.userId,
    required this.address,
    required this.cartModels,
  });
}
