import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({super.key, required this.w1, required this.w2});
  final String w1;
  final Widget w2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: w1, weight: FontWeight.w400, size: 16.sp),
        w2,
      ],
    );
  }
}
