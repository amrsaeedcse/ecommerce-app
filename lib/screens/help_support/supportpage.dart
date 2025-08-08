import 'package:ecommerceapp/bloc/sendsupport/send_support_cubit.dart';
import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController messageController = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 61.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: CustomText(
                      text: "Support",
                      weight: FontWeight.w700,
                      size: 16.sp,
                    ),
                  ),
                  Align(alignment: Alignment.centerLeft, child: Back()),
                ],
              ),
              Gap(40.h),
              CustomText(
                text: "Write your message",
                weight: FontWeight.w600,
                size: 14.sp,
              ),
              Gap(12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: messageController,
                  maxLines: 5,
                  decoration: InputDecoration.collapsed(
                    hintText: "Type your message here...",
                  ),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
              Gap(20.h),
              SizedBox(
                width: double.infinity,
                height: 45.h,
                child: BlocConsumer<SendSupportCubit, SendSupportState>(
                  listener: (context, state) {
                    if (state is SendSupportSuccess) {
                      SnackBarWarning.showSnack(
                        "thank you for your feedback we will contact you soon",
                        context,
                      );
                    } else if (state is SendSupportFailure) {
                      SnackBarWarning.showSnack(
                        "error happened try again later",
                        context,
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is SendSupportSuccess
                          ? () {
                              if (messageController.text.isNotEmpty) {
                                context.read<SendSupportCubit>().semEmail(
                                  messageController.text.trim(),
                                );
                                messageController.clear();
                              } else {
                                SnackBarWarning.showSnack(
                                  "Enter your message first",
                                  context,
                                );
                              }
                            }
                          : () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: state is SendSupportLoading
                          ? CupertinoActivityIndicator(
                              color: theme.colorScheme.surface,
                            )
                          : CustomText(
                              text: "Send",
                              weight: FontWeight.w600,
                              size: 14.sp,
                              color: Colors.white,
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
