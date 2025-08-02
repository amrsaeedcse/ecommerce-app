import 'package:ecommerceapp/data/checkout/checkoutmodel.dart';
import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/orderitemsgrid.dart';
import 'package:ecommerceapp/widgets/orderstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key, required this.checkOutModel});
  final CheckOutModel checkOutModel;
  int getProgressLevel(String progress) {
    switch (progress.toLowerCase()) {
      case 'processing':
        return 1;
      case 'shipped':
        return 2;
      case 'delivered':
        return 3;
      default:
        return 1; // Unknown or unhandled progress status
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 63.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 140.w,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      "Order  #${checkOutModel.orderId}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Align(alignment: Alignment.centerLeft, child: Back()),
              ],
            ),
            Gap(42.h),
            OrderState(level: getProgressLevel(checkOutModel.progress)),
            Gap(40.h),
            CustomText(
              text: "Order Items",
              weight: FontWeight.w700,
              size: 16.sp,
            ),
            Gap(16.h),
            Material(
              borderRadius: BorderRadius.circular(8.r),
              color: theme.colorScheme.onPrimary,

              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrderItemsGrid(cartModels: checkOutModel.cartModels),
                    ),
                  );
                },
                child: Container(
                  height: 72.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/images/icons/receipt1.svg"),
                        SizedBox(width: 20.w),
                        CustomText(
                          text: "${checkOutModel.cartModels.length} items",
                          weight: FontWeight.w700,
                          size: 16.sp,
                        ),
                        Spacer(),
                        CustomText(
                          text: "View All",
                          weight: FontWeight.w700,
                          size: 12,
                          color: theme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Gap(40.h),
            CustomText(
              text: "Shipping details",
              weight: FontWeight.w700,
              size: 16.sp,
            ),
            Gap(14.h),
            Container(
              height: 72.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Row(
                  children: [
                    Container(
                      width: 240.w,
                      child: CustomText(
                        text: checkOutModel.address,
                        weight: FontWeight.w500,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
