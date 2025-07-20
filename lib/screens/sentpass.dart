import 'package:ecommerceapp/widgets/CustomElevatedButton.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SentPass extends StatelessWidget {
  const SentPass({super.key});

  @override
  Widget build(BuildContext context) {
    ///////shouldnt be pushed
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/Email verification.json"),
              CustomText(
                text: "We Sent you an Email to reset your password.",
                weight: FontWeight.w500,
                size: 26,
              ),

              Gap(20),

              // width: 200,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90.0),
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
                    size: 17,
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
