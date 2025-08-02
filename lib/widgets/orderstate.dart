import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/orderstaterow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderState extends StatelessWidget {
  const OrderState({super.key, required this.level});
  final int level;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 249.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OrderStateRow(level: 3, text: "Delivered", currentLevel: level),
          OrderStateRow(level: 2, text: "Shipped", currentLevel: level),
          OrderStateRow(level: 1, text: "Order Confirmed", currentLevel: level),
          OrderStateRow(level: 0, text: "Order Placed", currentLevel: level),
        ],
      ),
    );
  }
}
