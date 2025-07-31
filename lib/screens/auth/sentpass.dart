import 'package:ecommerceapp/widgets/CustomElevatedButton.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // أضف دي

class SentPass extends StatelessWidget {
  const SentPass({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w), // ← هنا
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/Email verification.json"),
              CustomText(
                text: "We Sent you an Email to reset your password.",
                weight: FontWeight.w500,
                size: 26.sp, // ← هنا
              ),

              Gap(20.h), // ← هنا

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 90.w), // ← هنا
                child: CustomElevatedButton(
                  fun: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  color: theme.primaryColor,
                  customText: CustomText(
                    text: "Return to Login",
                    weight: FontWeight.w500,
                    size: 17.sp, // ← هنا
                    color: theme.colorScheme.surface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
