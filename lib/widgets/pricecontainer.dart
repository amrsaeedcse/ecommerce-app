import 'package:ecommerceapp/widgets/pricerow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'customtext.dart';
import 'gap.dart';

class PriceContainer extends StatelessWidget {
  const PriceContainer({
    super.key,
    required this.r1,
    required this.r2,
    required this.r3,
    required this.r4,
  });
  final String r1;
  final String r2;
  final String r3;
  final Widget r4;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PriceRow(
              w1: "Subtotal",
              w2: CustomText(text: r1, weight: FontWeight.w700, size: 16.sp),
            ),
            Gap(12.h),
            PriceRow(
              w1: "Shipping Cost",
              w2: CustomText(text: r2, weight: FontWeight.w700, size: 16.sp),
            ),
            Gap(12.h),
            PriceRow(
              w1: "Tax",
              w2: CustomText(text: r3, weight: FontWeight.w700, size: 16.sp),
            ),
            Gap(12.h),
            PriceRow(w1: "Total", w2: r4),
          ],
        ),
      ),
    );
  }
}
