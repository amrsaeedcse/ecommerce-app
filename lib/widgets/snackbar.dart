import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarWarning {
  static showSnack(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadiusGeometry.circular(20),
          ),
          child: Center(
            child: CustomText(
              text: message,
              weight: FontWeight.w500,
              size: 15,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }
}
