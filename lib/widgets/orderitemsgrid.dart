import 'package:ecommerceapp/data/cart/cartmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'back.dart';
import 'customtext.dart';
import 'gap.dart';

class OrderItemsGrid extends StatelessWidget {
  const OrderItemsGrid({super.key, required this.cartModels});
  final List<CartModel> cartModels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 63.h),

        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: SizedBox(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      "Order items",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Align(alignment: Alignment.centerLeft, child: Back()),
              ],
            ),

            Expanded(
              child: AnimationLimiter(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 161.w / 281.h,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.h,
                  ),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(milliseconds: 700),
                      child: SlideAnimation(
                        horizontalOffset: 100,
                        child: FadeInAnimation(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    GestureDetector(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        child: Image.network(
                                          cartModels[index].imageUrl,
                                          width: double.infinity,
                                          height: 220.h,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(8.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 150.w,
                                        ),
                                        child: CustomText(
                                          text: cartModels[index].name,
                                          weight: FontWeight.w500,
                                          size: 12.sp,
                                        ),
                                      ),
                                      Gap(8.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: cartModels[index].price
                                                .toString(),
                                            weight: FontWeight.w700,
                                            size: 12.sp,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.shopping_cart,
                                                size: 17.sp,
                                              ),
                                              SizedBox(width: 3.w),
                                              CustomText(
                                                text: cartModels[index].quantity
                                                    .toString(),
                                                weight: FontWeight.w700,
                                                size: 12.sp,
                                              ),
                                              SizedBox(width: 3.w),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: cartModels.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
