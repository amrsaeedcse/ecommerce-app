import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gap extends StatelessWidget {
  const Gap(this.h, {super.key});

  final double h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: h.h);
  }
}
