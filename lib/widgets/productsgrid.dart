import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/screens/product/productpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'customtext.dart';
import 'gap.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({super.key, required this.count, required this.data});
  final int count;
  final List<ProductModel> data;

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeAnim();
  }

  void makeAnim() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    slideAnimation = Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 161.w / 281.h,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
      ),
      itemBuilder: (context, index) {
        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Material(
              type: MaterialType.card,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductPage(productModel: widget.data[index]),
                    ),
                  );
                },
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
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.network(
                                widget.data[index].imageUrl,
                                width: double.infinity,
                                height: 220.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),

                          Positioned(
                            right: 8.w,
                            top: 5.h,
                            child: GestureDetector(
                              child: SvgPicture.asset(
                                "assets/images/icons/heart.svg",
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(8.h),
                      Padding(
                        padding: EdgeInsets.only(left: 4.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              constraints: BoxConstraints(maxWidth: 150.w),
                              child: CustomText(
                                text: widget.data[index].name,
                                weight: FontWeight.w500,
                                size: 12.sp,
                              ),
                            ),
                            Gap(8.h),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: widget.data[index].price.toString(),
                                  weight: FontWeight.w700,
                                  size: 12.sp,
                                ),
                                SizedBox(width: 8.w),
                                widget.data[index].isPriceChanged
                                    ? CustomText(
                                        text: widget.data[index].oldPrice
                                            .toString(),
                                        weight: FontWeight.w700,
                                        size: 12.sp,
                                        lined: true,
                                      )
                                    : SizedBox.shrink(),
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
          ),
        );
      },
      itemCount: widget.data.length,
    );
  }
}
