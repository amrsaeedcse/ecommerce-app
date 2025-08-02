import 'package:ecommerceapp/widgets/CustomElevatedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/customtext.dart';
import '../../widgets/gap.dart';
import '../catogeries/catogeriespage.dart';

class OrderEmpty extends StatelessWidget {
  const OrderEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 71.h),
      child: Column(
        children: [
          CustomText(text: "Orders", weight: FontWeight.w700, size: 24),
          Gap(216.h),
          Image.asset(
            "assets/images/icons/check-out 1.png",
            height: 100,
            fit: BoxFit.fitHeight,
          ),
          Gap(24.h),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 90.w),
            child: CustomElevatedButton(
              fun: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesPage()),
                );
              },
              color: theme.primaryColor,
              customText: CustomText(
                text: "Explore Categories",
                weight: FontWeight.w700,
                size: 16,
              ),
            ),
          ),
          Gap(24.h),
        ],
      ),
    );
    ;
  }
}
