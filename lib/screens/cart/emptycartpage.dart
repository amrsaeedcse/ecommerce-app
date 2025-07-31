import 'package:ecommerceapp/widgets/CustomElevatedButton.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../catogeries/catogeriespage.dart';

class EmptyCartPage extends StatelessWidget {
  const EmptyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/icons/parcel 1.png"),
          Gap(27.h),
          CustomText(
            text: "Your Cart is Empty",
            weight: FontWeight.w700,
            size: 27,
          ),
          Gap(27.h),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 102.5.w),
            child: CustomElevatedButton(
              fun: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesPage()),
                );
              },
              color: Theme.of(context).primaryColor,
              customText: CustomText(
                text: "Go to collections",
                weight: FontWeight.w700,
                size: 16,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
