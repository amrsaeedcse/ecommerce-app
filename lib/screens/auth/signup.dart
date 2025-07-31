import 'package:ecommerceapp/screens/auth/tellus.dart';
import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/customappbar.dart';
import 'package:ecommerceapp/widgets/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ضروري

import '../../widgets/CustomElevatedButton.dart';
import '../../widgets/customtext.dart';
import '../../widgets/gap.dart';
import '../../widgets/textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomPppBar(pr: Back()),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(50.h),
              CustomText(
                text: "Create Account",
                weight: FontWeight.w700,
                size: 32.sp,
              ),
              Gap(30.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 70.h,
                      child: CustomTextField(
                        hint: "Firstname",
                        cont: fNameCont,
                        type: InputType.name,
                      ),
                    ),
                    Gap(15.h),
                    SizedBox(
                      height: 70.h,
                      child: CustomTextField(
                        hint: "Lastname",
                        cont: lNameCont,
                        type: InputType.name,
                      ),
                    ),
                    Gap(15.h),
                    SizedBox(
                      height: 70.h,
                      child: CustomTextField(
                        hint: "Email Address",
                        cont: emailCont,
                        type: InputType.email,
                      ),
                    ),
                    Gap(15.h),
                    SizedBox(
                      height: 70.h,
                      child: CustomTextField(
                        hint: "Password",
                        cont: passCont,
                        type: InputType.password,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(30.h),
              CustomElevatedButton(
                color: Theme.of(context).primaryColor,
                customText: CustomText(
                  text: "Continue",
                  weight: FontWeight.w500,
                  size: 16.sp,
                  color: theme.colorScheme.surface,
                ),
                fun: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TellUs(
                          name: fNameCont.text.trim() + lNameCont.text.trim(),
                          pass: passCont.text.trim(),
                          email: emailCont.text.trim(),
                          from: ComeFrom.normal,
                        ),
                      ),
                    );
                  }
                },
              ),
              Gap(50.h),
              Row(
                children: [
                  CustomText(
                    text: "Forgot Password ? ",
                    weight: FontWeight.w500,
                    size: 12.sp,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CustomText(
                      text: "Reset",
                      weight: FontWeight.w700,
                      size: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
