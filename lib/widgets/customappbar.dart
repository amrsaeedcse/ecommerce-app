import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomPppBar({super.key, this.pr, this.su, this.cen});

  final Widget? pr;
  final Widget? su;
  final Widget? cen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      leading: null,

      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          pr ?? SizedBox.shrink(),
          cen ?? SizedBox.shrink(),
          su ?? SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(40.h);
}
