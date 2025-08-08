import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SittingRow extends StatelessWidget {
  const SittingRow({super.key, required this.onTap, required this.text});
  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
          height: 56.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: text, weight: FontWeight.w700, size: 16.sp),
              SvgPicture.asset("assets/images/icons/arrowright2.svg"),
            ],
          ),
        ),
      ),
    );
  }
}
