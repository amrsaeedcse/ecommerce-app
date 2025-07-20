import 'package:ecommerceapp/bloc/google/sign_inwith_google_cubit.dart';
import 'package:ecommerceapp/screens/signin2.dart';
import 'package:ecommerceapp/screens/signup.dart';
import 'package:ecommerceapp/screens/tellus.dart';
import 'package:ecommerceapp/widgets/CustomElevatedButton.dart';
import 'package:ecommerceapp/widgets/customappbar.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/homepage.dart';
import 'package:ecommerceapp/widgets/loading.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:ecommerceapp/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailCont = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void sendEmail() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return SignIn2(email: emailCont.text.trim());
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomPppBar(),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(50),
              CustomText(text: "Sign in", weight: FontWeight.w700, size: 32),
              Gap(30),
              Form(
                key: _formKey,
                child: Container(
                  height: 70,
                  child: CustomTextField(
                    hint: "Email Address",
                    cont: emailCont,
                    type: InputType.email,
                  ),
                ),
              ),
              Gap(20),
              CustomElevatedButton(
                color: Theme.of(context).primaryColor,
                customText: CustomText(
                  text: "Continue",
                  weight: FontWeight.w500,
                  size: 16,
                  color: theme.colorScheme.surface,
                ),
                fun: sendEmail,
              ),
              Gap(20),
              Row(
                children: [
                  CustomText(
                    text: "Don't have an Account ?",
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: CustomText(
                      text: "Create One",
                      weight: FontWeight.w700,
                      size: 12,
                    ),
                  ),
                ],
              ),
              Gap(40),
              CustomElevatedButton(
                icon: SvgPicture.asset("assets/images/icons/Apple.svg"),
                color: Theme.of(context).colorScheme.onPrimary,
                customText: CustomText(
                  text: "Continue With Apple",
                  weight: FontWeight.w500,
                  size: 16,
                ),
                fun: () {},
              ),
              Gap(10),
              BlocConsumer<SignInwithGoogleCubit, SignInwithGoogleState>(
                listener: (context, state) {
                  if (state is SignInwithGoogleLoading) {
                    Loading.showAlertLoading(context);
                  } else if (state is SignInwithGoogleFailure) {
                    Navigator.pop(context);
                    SnackBarWarning.showSnack(state.message, context);
                  } else if (state is SignInwithGoogleNew) {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TellUs(from: ComeFrom.google),
                      ),
                    );
                  } else if (state is SignInwithGoogleSuccess) {
                    Navigator.pop(context);
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    icon: Image.asset("assets/images/icons/Google - png 0.png"),

                    color: Theme.of(context).colorScheme.onPrimary,
                    customText: CustomText(
                      text: "Continue With Google",
                      weight: FontWeight.w500,
                      size: 16,
                    ),
                    fun: () {
                      context.read<SignInwithGoogleCubit>().signInWithGoogle();
                    },
                  );
                },
              ),
              Gap(10),
              CustomElevatedButton(
                icon: Image.asset("assets/images/icons/Facebook - png 0.png"),

                color: Theme.of(context).colorScheme.onPrimary,
                customText: CustomText(
                  text: "Continue With Facebook",
                  weight: FontWeight.w500,
                  size: 16,
                ),
                fun: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
