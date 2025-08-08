import 'package:ecommerceapp/bloc/navbartcontrol/nav_bar_control_cubit.dart';
import 'package:ecommerceapp/bloc/signout/sign_out_cubit.dart';
import 'package:ecommerceapp/screens/help_support/helppage.dart';
import 'package:ecommerceapp/screens/help_support/supportpage.dart';
import 'package:ecommerceapp/screens/information/address/addresspage.dart';
import 'package:ecommerceapp/screens/sitting/wishlistpage.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/profilephoto.dart';
import 'package:ecommerceapp/widgets/profilerow.dart';
import 'package:ecommerceapp/widgets/sittingrow.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:ecommerceapp/widgets/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SittingPage extends StatelessWidget {
  const SittingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.only(
          top: 129.h,
          left: 24.w,
          right: 24.w,
          bottom: 15.h,
        ),
        child: Column(
          children: [
            ProfilePhoto(l: 80, editable: true),
            Gap(32.h),
            ProfileRow(),
            Gap(26.h),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SittingRow(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddressPage(use: false),
                      ),
                    );
                  },
                  text: "Address",
                ),
                Gap(8.h),
                SittingRow(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WishListPage()),
                    );
                  },
                  text: "Wishlist",
                ),
                Gap(8.h),
                SittingRow(onTap: () {}, text: "Payment"),
                Gap(8.h),
                SittingRow(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => HelpPage()));
                  },
                  text: "Help",
                ),
                Gap(8.h),
                SittingRow(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SupportPage()),
                    );
                  },
                  text: "Support",
                ),
                Gap(23.h),
                BlocConsumer<SignOutCubit, SignOutState>(
                  listener: (context, state) {
                    if (state is SignOutFailure) {
                      SnackBarWarning.showSnack(
                        "error happened try again later",
                        context,
                      );
                    } else if (state is SignOutSuccess) {
                      Navigator.popUntil(context, ModalRoute.withName('first'));
                      context.read<NavBarControlCubit>().reset();
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: state is SignOutSuccess
                          ? () {
                              context.read<SignOutCubit>().signOut();
                            }
                          : () {},
                      child: state is SignOutLoading
                          ? CupertinoActivityIndicator(
                              color: theme.primaryColor,
                            )
                          : CustomText(
                              text: "Sign Out",
                              weight: FontWeight.w700,
                              size: 16.sp,
                              color: Colors.red,
                            ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
