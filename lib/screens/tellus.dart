import 'package:ecommerceapp/bloc/addDataWithGoogle/store_google_cubit.dart';
import 'package:ecommerceapp/bloc/age/age_control_cubit.dart';
import 'package:ecommerceapp/bloc/choose/choose_cubit.dart';
import 'package:ecommerceapp/bloc/signup/sign_up_cubit.dart';
import 'package:ecommerceapp/screens/signup.dart';
import 'package:ecommerceapp/widgets/homepage.dart';
import 'package:ecommerceapp/widgets/loading.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/CustomElevatedButton.dart';
import '../widgets/back.dart';
import '../widgets/customappbar.dart';
import '../widgets/customtext.dart';
import '../widgets/gap.dart';
import '../widgets/textfield.dart';

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
  String? selectedRange;
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
        return Container(
          height: 300,
          child: ListView.builder(
            itemCount: ageGroups.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.read<AgeControlCubit>().setValue(ageGroups[index]);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomText(
                    text: ageGroups[index],
                    weight: FontWeight.w500,
                    size: 20,
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
      bottomNavigationBar: widget.from == ComeFrom.normal
          ? BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  SnackBarWarning.showSnack("email created", context);
                } else if (state is SignUpEmailError) {
                  Navigator.pop(context);
                  SnackBarWarning.showSnack(
                    "this Email is already here",
                    context,
                  );
                } else if (state is SignUpLoading) {
                  Loading.showAlertLoading(context);
                } else if (state is SignUpFailure) {
                  Navigator.pop(context);
                  SnackBarWarning.showSnack("Error happened", context);
                }
              },
              builder: (context, state) {
                return BlocBuilder<AgeControlCubit, AgeControlState>(
                  builder: (context, state2) {
                    return Container(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomElevatedButton(
                          color: theme.primaryColor,
                          customText: CustomText(
                            text: "Finish",
                            weight: FontWeight.w500,
                            size: 28,
                            color: theme.colorScheme.surface,
                          ),
                          fun: state2.ageSelected == null
                              ? null
                              : () {
                                  String sex;
                                  if (context.read<ChooseCubit>().state
                                      is ChooseMen) {
                                    sex = "men";
                                  } else {
                                    sex = "women";
                                  }
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
            )
          : BlocBuilder<AgeControlCubit, AgeControlState>(
              builder: (context, state2) {
                return BlocConsumer<StoreGoogleCubit, StoreGoogleState>(
                  listener: (context, state) {
                    if (state is StoreGoogleFailure) {
                      Navigator.pop(context);
                      SnackBarWarning.showSnack("error", context);
                    } else if (state is StoreGoogleSuccess) {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else if (state is StoreGoogleLoading) {
                      Loading.showAlertLoading(context);
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomElevatedButton(
                          color: theme.primaryColor,
                          customText: CustomText(
                            text: "Finish",
                            weight: FontWeight.w500,
                            size: 28,
                            color: theme.colorScheme.surface,
                          ),
                          fun: state2.ageSelected == null
                              ? null
                              : () {
                                  //add google user ti db
                                  String sex;
                                  if (context.read<ChooseCubit>().state
                                      is ChooseMen) {
                                    sex = "men";
                                  } else {
                                    sex = "women";
                                  }
                                  String? age = context
                                      .read<AgeControlCubit>()
                                      .state
                                      .ageSelected;
                                  context.read<StoreGoogleCubit>().store(
                                    email: FirebaseAuth
                                        .instance
                                        .currentUser!
                                        .email!,
                                    name: FirebaseAuth
                                        .instance
                                        .currentUser!
                                        .displayName!,
                                    age: age!,
                                    sex: sex,
                                    userId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                  );
                                },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      appBar: CustomPppBar(pr: Back()),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(50),
            CustomText(
              text: "Tell us About yourself",
              weight: FontWeight.w700,
              size: 28,
            ),
            Gap(30),
            CustomText(
              text: "Who do you shop for ?",
              weight: FontWeight.w500,
              size: 16,
            ),
            Gap(20),
            BlocBuilder<ChooseCubit, ChooseState>(
              builder: (context, state) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        color: (state is ChooseWomen)
                            ? theme.colorScheme.onPrimary
                            : theme.primaryColor,
                        customText: CustomText(
                          text: "men",
                          weight: FontWeight.w500,
                          size: 16,
                          color: (state is ChooseWomen)
                              ? theme.colorScheme.surface
                              : null,
                        ),
                        fun: () {
                          context.read<ChooseCubit>().men();
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: CustomElevatedButton(
                        color: (state is ChooseMen)
                            ? theme.colorScheme.onPrimary
                            : theme.primaryColor,
                        customText: CustomText(
                          text: "women",
                          weight: FontWeight.w500,
                          size: 16,
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
            Gap(50),
            CustomText(
              text: "How Old are you ?",
              weight: FontWeight.w500,
              size: 18,
            ),
            Gap(30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.onPrimary,
              ),
              onPressed: showSheet,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<AgeControlCubit, AgeControlState>(
                      builder: (context, state) {
                        return CustomText(
                          text: state.ageSelected == null
                              ? "Age Range"
                              : state.ageSelected!,
                          weight: FontWeight.w500,
                          size: 15,
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
}

enum ComeFrom { google, normal }
