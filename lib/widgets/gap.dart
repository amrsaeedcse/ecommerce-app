import 'package:flutter/cupertino.dart';

class Gap extends StatelessWidget {
  const Gap(this.h, {super.key});

  final double h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: h);
  }
}
