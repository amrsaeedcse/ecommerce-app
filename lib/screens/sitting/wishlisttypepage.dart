import 'package:ecommerceapp/onetimeadded.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/wishlitsgrid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/product/productmodel.dart';
import '../../widgets/back.dart';
import '../../widgets/customtext.dart';

class WishListTypePage extends StatelessWidget {
  const WishListTypePage({super.key, required this.productModels});
  final List<ProductModel> productModels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 63.h, horizontal: 24.w),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(alignment: Alignment.centerLeft, child: Back()),
                Center(
                  child: CustomText(
                    text:
                        "${productModels[0].category}(${productModels.length.toString()})",
                    weight: FontWeight.w700,
                    size: 16.sp,
                  ),
                ),
              ],
            ),
            Gap(42.h),
            Expanded(child: WishListGrid(productModel: productModels)),
          ],
        ),
      ),
    );
  }
}
