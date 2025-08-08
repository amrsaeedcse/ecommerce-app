import 'package:ecommerceapp/bloc/signup/sign_up_cubit.dart';
import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/screens/homepage.dart';
import 'package:ecommerceapp/widgets/loading.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // أضفناها هنا

import '../../bloc/signIn/sign_in_cubit.dart';
import '../../widgets/CustomElevatedButton.dart';
import '../../widgets/customappbar.dart';
import '../../widgets/customtext.dart';
import '../../widgets/gap.dart';
import '../../widgets/textfield.dart';
import 'forgetpass.dart';

class SignIn2 extends StatelessWidget {
  SignIn2({super.key, required this.email});

  final String email;
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomPppBar(pr: Back()),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w), // 10 -> .w
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(50.h), // 50 -> .h
              CustomText(text: "Sign in", weight: FontWeight.w700, size: 32),
              Gap(30.h), // 30 -> .h
              Form(
                key: _formKey,
                child: SizedBox(
                  height: 70.h, // 70 -> .h
                  child: CustomTextField(
                    hint: "Password",
                    cont: passCont,
                    type: InputType.password,
                  ),
                ),
              ),
              Gap(20.h), // 20 -> .h
              BlocConsumer<SignInCubit, SignInState>(
                listener: (context, state) {
                  if (state is SignInLoading) {
                    Loading.showAlertLoading(context);
                  } else if (state is SignInFailure) {
                    Navigator.pop(context);
                    SnackBarWarning.showSnack(state.message, context);
                  } else if (state is SignInSuccess) {
                    Navigator.pop(context);
                    SnackBarWarning.showSnack("Welcome", context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                        settings: RouteSettings(name: 'home'),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    color: Theme.of(context).primaryColor,
                    customText: CustomText(
                      text: "Continue",
                      weight: FontWeight.w500,
                      size: 16,
                      color: theme.colorScheme.surface,
                    ),
                    fun: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignInCubit>().login(
                          email,
                          passCont.text.trim(),
                        );
                      }
                    },
                  );
                },
              ),
              Gap(20.h), // 20 -> .h
              Row(
                children: [
                  CustomText(
                    text: "Forgot Password ? ",
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ForgetPass(email: email),
                        ),
                      );
                    },
                    child: CustomText(
                      text: "Reset",
                      weight: FontWeight.w700,
                      size: 12,
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
