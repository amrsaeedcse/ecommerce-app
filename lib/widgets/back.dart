import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Back extends StatelessWidget {
  const Back({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.onPrimary,
      ),
      child: Material(
        child: InkWell(
          onTap: () => Navigator.pop(context),
          customBorder: CircleBorder(),
          child: Padding(
            padding: EdgeInsets.all(12.0.r),
            child: SvgPicture.asset("assets/images/icons/arrowleft2.svg"),
          ),
        ),
      ),
    );
  }
}
