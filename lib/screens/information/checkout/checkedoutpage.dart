import 'package:ecommerceapp/widgets/CustomElevatedButton.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckedOutPage extends StatefulWidget {
  const CheckedOutPage({super.key});

  @override
  State<CheckedOutPage> createState() => _CheckedOutPageState();
}

class _CheckedOutPageState extends State<CheckedOutPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Column(
        children: [
          Gap(145.h),
          SizedBox(
            height: 252.h,
            child: Image.asset(
              "assets/images/covers/image 3.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          Gap(68.h),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
                color: theme.colorScheme.surface,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 332.w,
                    child: CustomText(
                      text: "Order Placed Successfully",
                      weight: FontWeight.w700,
                      size: 32,
                    ),
                  ),
                  Gap(25.h),
                  Container(
                    width: 332.w,
                    child: CustomText(
                      text: "You will recieve an email confirmationy",
                      weight: FontWeight.w400,
                      size: 16,
                    ),
                  ),
                  Spacer(),
                  CustomElevatedButton(
                    fun: () {},
                    color: theme.primaryColor,
                    customText: CustomText(
                      text: "See Order details",
                      weight: FontWeight.w700,
                      size: 16,
                      color: theme.colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
