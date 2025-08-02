import 'package:ecommerceapp/animation/slidefadeanimation.dart';
import 'package:ecommerceapp/bloc/getCheckOuts/get_check_outs_cubit.dart';
import 'package:ecommerceapp/data/checkout/checkoutmodel.dart';
import 'package:ecommerceapp/widgets/orderrow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OrderList extends StatelessWidget {
  OrderList({super.key, required this.checkOutModels});
  final List<CheckOutModel> checkOutModels;
  @override
  Widget build(BuildContext context) {
    return checkOutModels.isNotEmpty
        ? RefreshIndicator(
            onRefresh: context.read<GetCheckOutsCubit>().getCheckOuts,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return SlideFadeAnimation(
                  widget: OrderRow(
                    checkOutModel: checkOutModels[index],
                    order: checkOutModels[index].orderId,
                    number: checkOutModels[index].cartModels.length,
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemCount: checkOutModels.length,
            ),
          )
        : Center(child: Lottie.asset("assets/lottie/Empty box.json"));
  }
}
