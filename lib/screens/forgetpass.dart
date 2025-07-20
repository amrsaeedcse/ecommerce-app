import 'package:ecommerceapp/bloc/forgetpass/forget_pass_cubit.dart';
import 'package:ecommerceapp/screens/sentpass.dart';
import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/CustomElevatedButton.dart';
import '../widgets/customappbar.dart';
import '../widgets/customtext.dart';
import '../widgets/gap.dart';
import '../widgets/textfield.dart';

class ForgetPass extends StatelessWidget {
  ForgetPass({super.key, required this.email});
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController emailCont = TextEditingController();
  final String email;

  @override
  Widget build(BuildContext context) {
    //the oldest code

    ////// here test git hub

    // maybe make somme things here

    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomPppBar(pr: Back()),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(50),
              CustomText(
                text: "Forgot Password",
                weight: FontWeight.w700,
                size: 32,
              ),
              Gap(30),
              Form(
                key: _formKey,
                child: Container(
                  height: 70,
                  child: CustomTextField(
                    hint: "Enter Email",
                    cont: emailCont,
                    type: InputType.email,
                  ),
                ),
              ),
              Gap(20),
              BlocConsumer<ForgetPassCubit, ForgetPassState>(
                listener: (context, state) {
                  if (state is ForgetPassSuccess) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SentPass()),
                    );
                  } else if (state is ForgetPassFailure) {
                    SnackBarWarning.showSnack(
                      "error append try later",
                      context,
                    );
                  } else if (state is ForgetPassLoading) {
                    SnackBarWarning.showSnack("Sending", context);
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    color: Theme.of(context).primaryColor,
                    customText: state is ForgetPassLoading
                        ? CupertinoActivityIndicator()
                        : CustomText(
                            text: "Continue",
                            weight: FontWeight.w500,
                            size: 16,
                            color: theme.colorScheme.surface,
                          ),
                    fun: () {
                      context.read<ForgetPassCubit>().sendPassReset(email);
                    },
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
