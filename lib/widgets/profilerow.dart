import 'package:ecommerceapp/bloc/getproile/get_profile_cubit.dart';
import 'package:ecommerceapp/getx/profilecontrol.dart';
import 'package:ecommerceapp/widgets/CustomElevatedButton.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/editprofile.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/textfield.dart';
import 'package:ecommerceapp/widgets/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

class ProfileRow extends StatefulWidget {
  // final profileController =Get.put(()=>ProfileControl());
  ProfileRow({super.key});

  @override
  State<ProfileRow> createState() => _ProfileRowState();
}

class _ProfileRowState extends State<ProfileRow> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<GetProfileCubit>().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<GetProfileCubit, GetProfileState>(
      builder: (context, state) {
        if (state is GetProfileFailure || state is GetProfileLoading) {
          return Shimmer.fromColors(
            highlightColor: theme.colorScheme.onPrimary,
            baseColor: theme.colorScheme.surface,
            child: Container(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w),
              height: 96.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: theme.colorScheme.onPrimary,
              ),
              child: Row(children: [Center()]),
            ),
          );
        }
        UserModel userModel = (state as GetProfileSuccess).userModel;
        return Container(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w),
          height: 96.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: theme.colorScheme.onPrimary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: userModel.name,
                    weight: FontWeight.w700,
                    size: 16.sp,
                  ),
                  Gap(8.h),
                  Opacity(
                    opacity: .5,
                    child: CustomText(
                      text: userModel.email,
                      weight: FontWeight.w500,
                      size: 16.sp,
                    ),
                  ),
                  Gap(8.h),
                  Opacity(
                    opacity: .5,
                    child: CustomText(
                      text: userModel.age,
                      weight: FontWeight.w500,
                      size: 16.sp,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    animationStyle: AnimationStyle(curve: Curves.easeIn),
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: EditProfile(userModel: userModel),
                        ),
                      );
                    },
                  );
                },
                child: CustomText(
                  text: "Edit",
                  weight: FontWeight.w700,
                  size: 12.sp,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
