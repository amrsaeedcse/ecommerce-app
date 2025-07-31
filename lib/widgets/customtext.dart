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
    this.lined,
  });
  final String text;
  final FontWeight weight;
  final double size;
  final Color? color;
  final bool? lined;

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      textAlign: TextAlign.start,
      softWrap: true,
      duration: Duration(milliseconds: 1000),
      style: TextStyle(
        fontWeight: weight,
        fontSize: size,
        color: color ?? Theme.of(context).colorScheme.primary,
        decoration: lined != null ? TextDecoration.lineThrough : null,
      ),
      child: Text(text),
    );
  }
}
