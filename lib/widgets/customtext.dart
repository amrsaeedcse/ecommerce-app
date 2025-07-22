import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.weight,
    required this.size,
    this.color,
  });
  final String text;
  final FontWeight weight;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      textAlign: TextAlign.center,
      softWrap: true,
      duration: Duration(milliseconds: 1000),
      style: TextStyle(
        fontWeight: weight,
        fontSize: size.sp,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
      child: Text(text),
    );
  }
}
