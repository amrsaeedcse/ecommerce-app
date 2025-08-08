import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/screens/sitting/wishlisttypepage.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishListRow extends StatelessWidget {
  const WishListRow({super.key, required this.productModels});
  final List<ProductModel> productModels;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.r),
      color: Theme.of(context).colorScheme.onPrimary,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  WishListTypePage(productModels: productModels),
            ),
          );
        },
        child: Container(
          height: 72.h,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/images/icons/heart.svg",
                width: 24.w,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(width: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: productModels[0].category,
                    weight: FontWeight.w700,
                    size: 16.sp,
                  ),
                  Gap(8.h),
                  Opacity(
                    opacity: .5,
                    child: CustomText(
                      text: productModels.length.toString() + " Products",
                      weight: FontWeight.w700,
                      size: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
