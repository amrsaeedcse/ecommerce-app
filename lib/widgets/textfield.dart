import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.cont,
    required this.type,
  });

  final String hint;
  final TextEditingController cont;
  final InputType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: Theme.of(context).colorScheme.primary,
      ),
      expands: true,
      maxLines: null,
      controller: cont,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: theme.colorScheme.onPrimary,
        ),
        filled: true,
        errorStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
          color: theme.colorScheme.primary,
        ),
        fillColor: theme.colorScheme.onPrimary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide.none,
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        switch (type) {
          case InputType.email:
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your email !';
            }
            if (!RegExp(
              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
            ).hasMatch(value.trim())) {
              return 'Please enter a valid email address !';
            }
            return null; // va
          case InputType.password:
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your password !';
            }
            if (value.trim().length < 6) {
              return 'Password must be at least 6 characters long !';
            }
            if (!RegExp(
              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{6,}$',
            ).hasMatch(value.trim())) {
              return 'Password must contain upper, lower case letters and a number !';
            }
            return null; // valid

          case InputType.name:
            if (value == null || value.trim().isEmpty) {
              return 'Name is required !';
            }
            if (value.length < 2) {
              return 'Name is too short !';
            }
            return null;
        }
      },
    );
  }
}

enum InputType { email, password, name }
