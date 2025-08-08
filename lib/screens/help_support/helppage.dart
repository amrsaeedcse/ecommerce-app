import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 61.h),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: CustomText(
                    text: "Help",
                    weight: FontWeight.w700,
                    size: 16.sp,
                  ),
                ),
                Align(alignment: Alignment.centerLeft, child: Back()),
              ],
            ),
            Gap(30.h),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ExpansionTile(
                    iconColor: theme.primaryColor,
                    collapsedIconColor: theme.primaryColor,
                    title: CustomText(
                      text: "What is this app about?",
                      weight: FontWeight.w600,
                      size: 14.sp,
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.h,
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: CustomText(
                          text:
                              "This app is designed to help you shop easily for trendy fashion like hoodies, sneakers, and more. You can explore categories, discover new arrivals, and shop directly from your phone.",
                          weight: FontWeight.w400,
                          size: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    iconColor: theme.primaryColor,
                    collapsedIconColor: theme.primaryColor,
                    title: CustomText(
                      text: "How can I sign up or log in?",
                      weight: FontWeight.w600,
                      size: 14.sp,
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.h,
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: CustomText(
                          text:
                              "You can sign up with your email or Google account. Facebook and Apple login options are coming soon. If you forget your password, you can reset it from the login page.",
                          weight: FontWeight.w400,
                          size: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    iconColor: theme.primaryColor,
                    collapsedIconColor: theme.primaryColor,
                    title: CustomText(
                      text: "How can I place an order?",
                      weight: FontWeight.w600,
                      size: 14.sp,
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.h,
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: CustomText(
                          text:
                              "Select a product, choose your size, color, and quantity. You can apply coupon codes, select or add an address, and confirm your order. You will receive a confirmation email and an in-app notification.",
                          weight: FontWeight.w400,
                          size: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    iconColor: theme.primaryColor,
                    collapsedIconColor: theme.primaryColor,
                    title: CustomText(
                      text: "Can I change my profile info?",
                      weight: FontWeight.w600,
                      size: 14.sp,
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.h,
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: CustomText(
                          text:
                              "Yes, you can update your name, age, and address from the Settings. However, if you signed in with Google, you won’t be able to change your email.",
                          weight: FontWeight.w400,
                          size: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    iconColor: theme.primaryColor,
                    collapsedIconColor: theme.primaryColor,
                    title: CustomText(
                      text: "How to search or filter products?",
                      weight: FontWeight.w600,
                      size: 14.sp,
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.h,
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: CustomText(
                          text:
                              "Use the search bar to find specific products. You can also filter by gender (men/women), price range, or categories to find what suits you best.",
                          weight: FontWeight.w400,
                          size: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    iconColor: theme.primaryColor,
                    collapsedIconColor: theme.primaryColor,
                    title: CustomText(
                      text: "Need more help?",
                      weight: FontWeight.w600,
                      size: 14.sp,
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.h,
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: CustomText(
                          text:
                              "If you need further assistance, please contact our support team. You can find the Contact Support option in the app, or reach us by email anytime bdalzymmrw@gmail.com.",
                          weight: FontWeight.w400,
                          size: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
