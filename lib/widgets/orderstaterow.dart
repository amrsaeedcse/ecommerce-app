import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'customtext.dart';

class OrderStateRow extends StatelessWidget {
  const OrderStateRow({
    super.key,
    required this.level,
    required this.text,
    required this.currentLevel,
  });
  final int level;

  final String text;
  final int currentLevel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Opacity(
          opacity: (currentLevel < level) ? .2 : 1,
          child: Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.surface,
              size: 8.sp,
            ),
          ),
        ),
        CustomText(text: text, weight: FontWeight.w700, size: 16),
      ],
    );
  }
}
