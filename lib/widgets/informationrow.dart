import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'customtext.dart';
import 'gap.dart';

class InformationRow extends StatelessWidget {
  const InformationRow({
    super.key,
    required this.s1,
    required this.s2,
    required this.onTap,
  });
  final String s1;
  final String s2;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          height: 72.h,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: s1, weight: FontWeight.w400, size: 12.sp),
                  Gap(4.h),
                  SizedBox(
                    width: 248.w,
                    child: CustomText(
                      text: s2,
                      weight: FontWeight.w700,
                      size: 16.sp,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                "assets/images/icons/arrowright2.svg",
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
