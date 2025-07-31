import 'package:ecommerceapp/data/cart/cartmodel.dart';
import 'package:ecommerceapp/widgets/addorremove.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartRow extends StatelessWidget {
  const CartRow({super.key, required this.cartModel});
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.max,

          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(4.r),
              child: Image.network(
                cartModel.imageUrl,
                width: 64.w,
                height: 64.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: cartModel.name,
                        weight: FontWeight.w500,
                        size: 12.sp,
                      ),
                      CustomText(
                        text: (cartModel.price * cartModel.quantity)
                            .toStringAsFixed(2),
                        weight: FontWeight.w500,
                        size: 12.sp,
                      ),
                    ],
                  ),
                  Gap(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: "Size-",
                            weight: FontWeight.w400,
                            size: 12.sp,
                          ),
                          CustomText(
                            text: cartModel.size,
                            weight: FontWeight.w700,
                            size: 12.sp,
                          ),
                          SizedBox(width: 16.w),
                          CustomText(
                            text: "Color-",
                            weight: FontWeight.w400,
                            size: 12.sp,
                          ),
                          CustomText(
                            text: cartModel.color,
                            weight: FontWeight.w700,
                            size: 12.sp,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AddOrRemove(tap: () {}, icon: Icons.add),
                          SizedBox(width: 8.w),
                          AddOrRemove(tap: () {}, icon: Icons.remove),
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
    );
  }
}
