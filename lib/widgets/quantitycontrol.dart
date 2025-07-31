import 'package:ecommerceapp/bloc/quantitnycontrol/quantity_control_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../getx/finalratingcont.dart';
import 'customtext.dart';

class QuantityControl extends StatelessWidget {
  QuantityControl({super.key});

  final controller = Get.find<RatingController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: theme.primaryColor,
          shape: CircleBorder(),
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              context.read<QuantityControlCubit>().add();
            },
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Center(
                child: Icon(Icons.add, color: theme.colorScheme.surface),
              ),
            ),
          ),
        ),

        SizedBox(width: 23.w),
        BlocBuilder<QuantityControlCubit, QuantityControlState>(
          builder: (context, state) {
            controller.setQuantity(state.counter);
            return CustomText(
              text: state.counter.toString(),
              weight: FontWeight.w700,
              size: 16,
            );
          },
        ),
        SizedBox(width: 23.w),
        Material(
          color: theme.primaryColor,
          shape: CircleBorder(),
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              context.read<QuantityControlCubit>().minus();
            },
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Center(
                child: Icon(Icons.remove, color: theme.colorScheme.surface),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
