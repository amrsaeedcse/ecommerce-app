import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'customtext.dart';

class TextRow extends StatelessWidget {
  const TextRow({
    super.key,
    required this.t1,
    required this.t2,
    required this.onTap,
  });
  final String t1;
  final String t2;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: t1, weight: FontWeight.w700, size: 16.sp),
        GestureDetector(
          onTap: onTap,
          child: CustomText(text: t2, weight: FontWeight.w500, size: 16.sp),
        ),
      ],
    );
  }
}
