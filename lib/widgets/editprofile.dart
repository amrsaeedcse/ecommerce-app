import 'package:ecommerceapp/bloc/editpofile/edit_profile_cubit.dart';
import 'package:ecommerceapp/bloc/getproile/get_profile_cubit.dart';
import 'package:ecommerceapp/getx/profilecontrol.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:ecommerceapp/widgets/textfield.dart';
import 'package:ecommerceapp/widgets/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'CustomElevatedButton.dart';
import 'customtext.dart';
import 'gap.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  late TextEditingController name;

  late TextEditingController email;

  TextEditingController age = TextEditingController();
  List<String> ageGroups = ['18-24', '25-34', '35-44', '45-54', '55-64', '65+'];
  final profileCont = Get.put(ProfileControl());

  @override
  void initState() {
    // TODO: implement initState
    email = TextEditingController(text: widget.userModel.email);

    name = TextEditingController(text: widget.userModel.name);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<ProfileControl>();
    super.dispose();
  }

  bool checkIfGoogleUser() {
    bool isGoogleUser = false;
    final user = FirebaseAuth.instance.currentUser;
    for (final provider in user!.providerData) {
      if (provider.providerId == "google.com") {
        return true;
      }
    }
    //TODO still handle it
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 500.h,
      width: 200.w,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: CustomText(
                      text: "Edit Your Profile",
                      weight: FontWeight.w700,
                      size: 12.sp,
                    ),
                  ),
                  BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                      return state is! EditProfileLoading
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 30.sp,
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {},
                                child: Opacity(
                                  opacity: .3,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 30.sp,
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
              Gap(10.h),
              checkIfGoogleUser()
                  ? Opacity(
                      opacity: .4,
                      child: GestureDetector(
                        onTap: () {
                          SnackBarWarning.showSnack(
                            "you cannot edit your email while signing in with google",
                            context,
                          );
                        },
                        child: AbsorbPointer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 50.h,
                                child: CustomTextField(
                                  hint: "Enter your name",
                                  cont: email,
                                  type: InputType.email,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 50.h,
                          child: CustomTextField(
                            hint: "Enter your name",
                            cont: email,
                            type: InputType.email,
                          ),
                        ),
                      ],
                    ),
              Gap(20.h),
              SizedBox(
                height: 50.h,
                child: CustomTextField(
                  hint: "Enter your name",
                  cont: name,
                  type: InputType.name,
                ),
              ),
              Gap(20.h),
              Obx(() {
                return Center(
                  child: PopupMenuButton(
                    initialValue: widget.userModel.age,
                    onSelected: (value) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        if (mounted) {
                          profileCont.age.value = value;
                        }
                      });
                    },
                    constraints: BoxConstraints.tightFor(
                      height: 200.h,
                      width: 206.w,
                    ),
                    offset: Offset(0, 0),
                    position: PopupMenuPosition.under,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r.r),
                      borderSide: BorderSide.none,
                    ),
                    child: Container(
                      height: 30.h,
                      width: 206.w,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: theme.primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            text: profileCont.age.value != null
                                ? profileCont.age.value!
                                : widget.userModel.age,
                            weight: FontWeight.w700,
                            size: 12.sp,
                            color: theme.colorScheme.surface,
                          ),
                          SizedBox(width: 10.w),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                    itemBuilder: (context) => ageGroups.map((e) {
                      return PopupMenuItem(
                        value: e,
                        child: CustomText(
                          text: e.toString(),
                          weight: FontWeight.w700,
                          size: 10.sp,
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
              Spacer(),
              BlocConsumer<EditProfileCubit, EditProfileState>(
                listener: (context, state) {
                  if (state is EditProfileFailure) {
                    SnackBarWarning.showSnack("error happened", context);
                    Navigator.pop(context);
                  } else if (state is EditProfileSuccess) {
                    SnackBarWarning.showSnack("changed successfully", context);
                    context.read<GetProfileCubit>().getProfile();
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    fun: state is EditProfileSuccess
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              if (profileCont.age.value == null &&
                                  email.text == widget.userModel.email &&
                                  name.text == widget.userModel.name) {
                                SnackBarWarning.showSnack(
                                  "you did not change anything",
                                  context,
                                );
                              } else {
                                context.read<EditProfileCubit>().editProfile(
                                  UserModel(
                                    email: email.text.trim(),
                                    name: name.text.trim(),
                                    age: profileCont.age.value == null
                                        ? widget.userModel.age
                                        : profileCont.age.value!,
                                    sex: widget.userModel.sex,
                                  ),
                                );
                              }
                            }
                          }
                        : () {},
                    color: theme.primaryColor,
                    customText: state is EditProfileSuccess
                        ? CustomText(
                            text: "Edit",
                            weight: FontWeight.w700,
                            size: 15.h,
                            color: theme.colorScheme.surface,
                          )
                        : CupertinoActivityIndicator(
                            color: theme.colorScheme.surface,
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
