import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductOption extends StatelessWidget {
  ProductOption({
    super.key,
    required this.suffix,
    required this.t1,
    this.color,
    this.textColor,
    this.onTap,
  });
  Widget? suffix;
  String t1;
  Color? color;
  Color? textColor;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: t1,
                weight: FontWeight.w700,
                size: 16,
                color: textColor,
              ),
              ?suffix,
            ],
          ),
        ),
      ),
    );
  }
}
