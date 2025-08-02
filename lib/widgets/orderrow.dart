import 'package:ecommerceapp/data/checkout/checkoutmodel.dart';
import 'package:ecommerceapp/screens/orders/orderpage.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderRow extends StatelessWidget {
  const OrderRow({
    super.key,
    required this.order,
    required this.number,
    required this.checkOutModel,
  });
  final String order;
  final int number;
  final CheckOutModel checkOutModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderPage(checkOutModel: checkOutModel),
            ),
          );
        },
        child: Container(
          height: 72.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset("assets/images/icons/receipt1.svg"),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 170.w,
                          child: Text(
                            "Order  #" + order,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Gap(2.h),
                        Container(
                          width: 140.w,
                          child: CustomText(
                            text: number.toString(),
                            weight: FontWeight.w700,
                            size: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SvgPicture.asset("assets/images/icons/arrowright2.svg"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
