import 'package:ecommerceapp/animation/fadeanimation.dart';
import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/screens/product/productpage.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.data,
    required this.onTpaImage,
    required this.onTpaLike,
  });
  final List<ProductModel> data;

  final void Function() onTpaImage;
  final void Function() onTpaLike;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 282.h,

      child: data.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 12.0.w),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(productModel: data[index]),
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
                                  onTap: onTpaImage,
                                  child: FadeAnimation(
                                    w: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.network(
                                        data[index].imageUrl,
                                        width: 159.w,
                                        height: 220.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  right: 8.w,
                                  top: 5.h,
                                  child: GestureDetector(
                                    onTap: onTpaLike,
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
                                    constraints: BoxConstraints(
                                      maxWidth: 150.w,
                                    ),
                                    child: CustomText(
                                      text: data[index].name,
                                      weight: FontWeight.w500,
                                      size: 12.sp,
                                    ),
                                  ),
                                  Gap(8.h),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                        text: data[index].price.toString(),
                                        weight: FontWeight.w700,
                                        size: 12.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      data[index].isPriceChanged
                                          ? CustomText(
                                              text: data[index].oldPrice
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
                );
              },
            )
          : Container(
              width: double.infinity,
              child: Lottie.asset("assets/lottie/Empty box.json"),
            ),
    );
  }
}
