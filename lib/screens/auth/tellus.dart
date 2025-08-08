import 'package:ecommerceapp/bloc/addDataWithGoogle/store_google_cubit.dart';
import 'package:ecommerceapp/bloc/age/age_control_cubit.dart';
import 'package:ecommerceapp/bloc/choose/choose_cubit.dart';
import 'package:ecommerceapp/bloc/signup/sign_up_cubit.dart';
import 'package:ecommerceapp/screens/auth/signup.dart';
import 'package:ecommerceapp/screens/homepage.dart';
import 'package:ecommerceapp/widgets/loading.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/CustomElevatedButton.dart';
import '../../widgets/back.dart';
import '../../widgets/customappbar.dart';
import '../../widgets/customtext.dart';
import '../../widgets/gap.dart';
import '../../widgets/textfield.dart';

class TellUs extends StatefulWidget {
  const TellUs({
    super.key,
    this.name,
    this.pass,
    this.email,
    required this.from,
  });

  final String? name;
  final String? pass;
  final String? email;
  final ComeFrom from;

  @override
  State<TellUs> createState() => _TellUsState();
}

class _TellUsState extends State<TellUs> {
  void showSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        List<String> ageGroups = [
          '18-24',
          '25-34',
          '35-44',
          '45-54',
          '55-64',
          '65+',
        ];
        return SizedBox(
          height: 300.h,
          child: ListView.builder(
            itemCount: ageGroups.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.read<AgeControlCubit>().setValue(ageGroups[index]);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(12.0.h),
                  child: CustomText(
                    text: ageGroups[index],
                    weight: FontWeight.w500,
                    size: 20.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomPppBar(pr: Back()),
      backgroundColor: theme.colorScheme.secondary,
      bottomNavigationBar: widget.from == ComeFrom.normal
          ? _buildNormalBottom(theme)
          : _buildGoogleBottom(theme),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(50.h),
            CustomText(
              text: "Tell us About yourself",
              weight: FontWeight.w700,
              size: 28.sp,
            ),
            Gap(30.h),
            CustomText(
              text: "Who do you shop for ?",
              weight: FontWeight.w500,
              size: 16.sp,
            ),
            Gap(20.h),
            BlocBuilder<ChooseCubit, ChooseState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        color: (state is ChooseWomen)
                            ? theme.colorScheme.onPrimary
                            : theme.primaryColor,
                        customText: CustomText(
                          text: "men",
                          weight: FontWeight.w500,
                          size: 16.sp,
                          color: (state is ChooseWomen)
                              ? theme.colorScheme.surface
                              : null,
                        ),
                        fun: () {
                          context.read<ChooseCubit>().men();
                        },
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: CustomElevatedButton(
                        color: (state is ChooseMen)
                            ? theme.colorScheme.onPrimary
                            : theme.primaryColor,
                        customText: CustomText(
                          text: "women",
                          weight: FontWeight.w500,
                          size: 16.sp,
                          color: (state is ChooseMen)
                              ? theme.colorScheme.surface
                              : null,
                        ),
                        fun: () {
                          context.read<ChooseCubit>().women();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            Gap(50.h),
            CustomText(
              text: "How Old are you ?",
              weight: FontWeight.w500,
              size: 18.sp,
            ),
            Gap(30.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.onPrimary,
              ),
              onPressed: showSheet,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<AgeControlCubit, AgeControlState>(
                      builder: (context, state) {
                        return CustomText(
                          text: state.ageSelected ?? "Age Range",
                          weight: FontWeight.w500,
                          size: 15.sp,
                        );
                      },
                    ),
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalBottom(ThemeData theme) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          SnackBarWarning.showSnack("email created", context);
        } else if (state is SignUpEmailError) {
          Navigator.pop(context);
          SnackBarWarning.showSnack("this Email is already here", context);
        } else if (state is SignUpLoading) {
          Loading.showAlertLoading(context);
        } else if (state is SignUpFailure) {
          Navigator.pop(context);
          SnackBarWarning.showSnack("Error happened", context);
        }
      },
      builder: (context, _) {
        return BlocBuilder<AgeControlCubit, AgeControlState>(
          builder: (context, state2) {
            return SizedBox(
              height: 100.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomElevatedButton(
                  color: theme.primaryColor,
                  customText: CustomText(
                    text: "Finish",
                    weight: FontWeight.w500,
                    size: 28.sp,
                    color: theme.colorScheme.surface,
                  ),
                  fun: state2.ageSelected == null
                      ? null
                      : () {
                          final sex =
                              context.read<ChooseCubit>().state is ChooseMen
                              ? "men"
                              : "women";
                          context.read<SignUpCubit>().signUp(
                            email: widget.email!,
                            pass: widget.pass!,
                            name: widget.name!,
                            age: state2.ageSelected!,
                            sex: sex,
                          );
                        },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGoogleBottom(ThemeData theme) {
    return BlocBuilder<AgeControlCubit, AgeControlState>(
      builder: (context, state2) {
        return BlocConsumer<StoreGoogleCubit, StoreGoogleState>(
          listener: (context, state) {
            if (state is StoreGoogleFailure) {
              Navigator.pop(context);
              SnackBarWarning.showSnack("error", context);
            } else if (state is StoreGoogleSuccess) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                  settings: RouteSettings(name: 'home'),
                ),
              );
            } else if (state is StoreGoogleLoading) {
              Loading.showAlertLoading(context);
            }
          },
          builder: (context, _) {
            return SizedBox(
              height: 100.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomElevatedButton(
                  color: theme.primaryColor,
                  customText: CustomText(
                    text: "Finish",
                    weight: FontWeight.w500,
                    size: 28.sp,
                    color: theme.colorScheme.surface,
                  ),
                  fun: state2.ageSelected == null
                      ? null
                      : () {
                          final sex =
                              context.read<ChooseCubit>().state is ChooseMen
                              ? "men"
                              : "women";
                          final user = FirebaseAuth.instance.currentUser!;
                          context.read<StoreGoogleCubit>().store(
                            email: user.email!,
                            name: user.displayName!,
                            age: state2.ageSelected!,
                            sex: sex,
                            userId: user.uid,
                          );
                        },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

enum ComeFrom { google, normal }
