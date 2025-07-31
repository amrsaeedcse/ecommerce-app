import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBarWarning {
  static showSnack(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Center(
          child: CustomText(
            text: message,
            weight: FontWeight.w700,
            size: 15,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
