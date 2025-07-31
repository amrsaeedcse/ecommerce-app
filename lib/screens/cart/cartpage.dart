import 'package:ecommerceapp/bloc/getAddresses/get_addresses_cubit.dart';
import 'package:ecommerceapp/bloc/getcartcontrol/get_cart_control_cubit.dart';
import 'package:ecommerceapp/bloc/removeall/remove_all_cubit.dart';
import 'package:ecommerceapp/data/cart/cartmodel.dart';
import 'package:ecommerceapp/getx/pricecontrol.dart';
import 'package:ecommerceapp/screens/information/checkout/checkout.dart';
import 'package:ecommerceapp/screens/cart/emptycartpage.dart';
import 'package:ecommerceapp/widgets/CustomElevatedButton.dart';
import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/cartlist.dart';
import 'package:ecommerceapp/widgets/coupontextfield.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/pricecontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final priceController = Get.put(PriceControl());

  @override
  void initState() {
    // TODO: implement initState
    context.read<GetCartControlCubit>().getCart();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<PriceControl>();
    super.dispose();
  }

  TextEditingController textCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: BlocBuilder<GetCartControlCubit, GetCartControlState>(
          builder: (context, state) {
            if (state is GetCartControlLoading) {
              return Center(
                child: Lottie.asset("assets/lottie/search imm.json"),
              );
            } else if (state is GetCartControlEmpty) {
              // print("emty");
              return EmptyCartPage();
            } else if (state is GetCartControlFailure) {
              // print("fale");
              return EmptyCartPage();
            }
            List<CartModel> cartModels =
                (state as GetCartControlSuccess).cartModels;
            return Padding(
              padding: EdgeInsets.only(right: 24.0.w, left: 24.w, bottom: 34.h),
              child: Column(
                children: [
                  Gap(63.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(alignment: Alignment.centerLeft, child: Back()),
                      Center(
                        child: CustomText(
                          text: "Cart",
                          weight: FontWeight.w700,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  Gap(20.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: BlocBuilder<RemoveAllCubit, RemoveAllState>(
                      builder: (context, state) {
                        return state is! RemoveAllLoading
                            ? InkWell(
                                customBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                onTap: () async {
                                  await context
                                      .read<RemoveAllCubit>()
                                      .deleteAll();
                                  context.read<GetCartControlCubit>().getCart();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0.r),
                                  child: CustomText(
                                    text: "Remove All",
                                    weight: FontWeight.w500,
                                    size: 16,
                                  ),
                                ),
                              )
                            : CupertinoActivityIndicator(
                                color: theme.primaryColor,
                              );
                      },
                    ),
                  ),
                  Gap(16.h),

                  SizedBox(
                    height: 168.h,
                    child: CartList(cartModels: cartModels),
                  ),
                  Gap(170.h),
                  Hero(
                    tag: "2",
                    child: Obx(() {
                      return PriceContainer(
                        r1: "\$" + priceController.subTotal.value.toString(),
                        r2: "\$${priceController.shippingCost.value}",
                        r3: "\$" + priceController.tax.value.toString(),
                        r4: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text:
                                  "\$" + priceController.total.value.toString(),
                              weight: FontWeight.w700,
                              size: 16.sp,
                              lined: priceController.isDis.value ? true : null,
                            ),
                            priceController.isDis.value
                                ? SizedBox(width: 20.w)
                                : SizedBox.shrink(),
                            priceController.isDis.value
                                ? CustomText(
                                    text:
                                        "\$${priceController.total.value - priceController.disCost.value}",

                                    weight: FontWeight.w700,
                                    size: 16.sp,
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      );
                    }),
                  ),
                  Gap(31.h),
                  CouponTextField(textCont: textCont),
                  Expanded(child: Center()),
                  SizedBox(
                    child: CustomElevatedButton(
                      fun: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => GetAddressesCubit(),
                              child: CheckOut(),
                            ),
                          ),
                        );
                      },
                      color: theme.primaryColor,
                      customText: CustomText(
                        text: "Checkout",
                        weight: FontWeight.w700,
                        size: 16,
                        color: theme.colorScheme.surface,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
