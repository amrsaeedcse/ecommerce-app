import 'package:ecommerceapp/bloc/getCheckOuts/get_check_outs_cubit.dart';
import 'package:ecommerceapp/screens/orders/order1.dart';
import 'package:ecommerceapp/screens/orders/orderempty.dart';
import 'package:ecommerceapp/widgets/customtab.dart';
import 'package:ecommerceapp/widgets/customtabbar.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Page2 extends StatefulWidget {
  Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  PageController pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    context.read<GetCheckOutsCubit>().getCheckOuts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<GetCheckOutsCubit, GetCheckOutsState>(
      builder: (context, state) {
        if (state is GetCheckOutsLoading) {
          return Center(
            child: CupertinoActivityIndicator(color: theme.primaryColor),
          );
        } else if (state is GetCheckOutsEmpty) {
          return OrderEmpty();
        } else if (state is GetCheckOutsFailure) {
          print(state);
          return OrderEmpty();
        }
        return Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 71.h),
          child: Column(
            children: [
              CustomText(text: "Orders", weight: FontWeight.w700, size: 24),
              Gap(40.h),
              CustomTabBar(pageController: pageController),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    OrderList(
                      checkOutModels: (state as GetCheckOutsSuccess)
                          .checkOutModels
                          .where((order) => order.progress == "Processing")
                          .toList(),
                    ),

                    OrderList(
                      checkOutModels: (state).checkOutModels
                          .where((order) => order.progress == "Shipped")
                          .toList(),
                    ),

                    // Level 3 - Delivered
                    OrderList(
                      checkOutModels: (state).checkOutModels
                          .where((order) => order.progress == "Delivered")
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
