import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/categorieslist.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(63.h),
            Back(),
            Gap(16.h),
            CustomText(
              text: "Shop by Categories",
              weight: FontWeight.w700,
              size: 24,
            ),
            Gap(14.h),
            Flexible(child: CategoriesList()),
          ],
        ),
      ),
    );
  }
}
