import 'package:ecommerceapp/bloc/gethomepagecat/get_home_page_cat_cubit.dart';
import 'package:ecommerceapp/bloc/getwishlist/get_wish_list_cubit.dart';
import 'package:ecommerceapp/bloc/resetbloc/reset_pr_inwish_grid_cubit.dart';
import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:ecommerceapp/widgets/heartfav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';

import '../firebase/firestore/FireBaseFireStore.dart';
import '../screens/product/productpage.dart';
import 'customtext.dart';
import 'gap.dart';

class WishListGrid extends StatefulWidget {
  const WishListGrid({super.key, required this.productModel});
  final List<ProductModel> productModel;

  @override
  State<WishListGrid> createState() => _WishListGridState();
}

class _WishListGridState extends State<WishListGrid> {
  late GetWishListCubit wishListCubit;

  @override
  void initState() {
    super.initState();
    wishListCubit = context.read<GetWishListCubit>();
    print(widget.productModel[0].isFav);
  }

  @override
  void dispose() {
    wishListCubit.getWishList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPrInwishGridCubit, ResetPrInwishGridState>(
      builder: (context, state) {
        return AnimationLimiter(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 161.w / 281.h,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
            ),
            itemBuilder: (context, index) {
              final FireBaseFireStore fireBase = getIt<FireBaseFireStore>();

              if (fireBase.someProducts.contains(widget.productModel[index])) {
                print("here");
                //that means u send it directly
              } else {
                int elementIndex = -1;
                for (int i = 0; i < fireBase.someProducts.length; i++) {
                  if (fireBase.someProducts[i].id ==
                      widget.productModel[index].id) {
                    elementIndex = i;
                  }
                }
                if (elementIndex != -1) {
                  widget.productModel[index] =
                      fireBase.someProducts[elementIndex];
                }
              }
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(milliseconds: 700),
                child: SlideAnimation(
                  horizontalOffset: 100,
                  child: FadeInAnimation(
                    child: Material(
                      type: MaterialType.card,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                productModel: widget.productModel[index],
                              ),
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
                                        widget.productModel[index].imageUrl,
                                        width: double.infinity,
                                        height: 220.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    right: 8.w,
                                    top: 5.h,
                                    child: HeartFav(
                                      additionalTap: () {
                                        context
                                            .read<GetHomePageCatCubit>()
                                            .reset();
                                        context
                                            .read<ResetPrInwishGridCubit>()
                                            .reset();
                                      },
                                      productModel: widget.productModel[index],
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
                                        text: widget.productModel[index].name,
                                        weight: FontWeight.w500,
                                        size: 12.sp,
                                      ),
                                    ),
                                    Gap(8.h),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          text: widget.productModel[index].price
                                              .toString(),
                                          weight: FontWeight.w700,
                                          size: 12.sp,
                                        ),
                                        SizedBox(width: 8.w),
                                        widget
                                                .productModel[index]
                                                .isPriceChanged
                                            ? CustomText(
                                                text: widget
                                                    .productModel[index]
                                                    .oldPrice
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
                ),
              );
            },
            itemCount: widget.productModel.length,
          ),
        );
      },
    );
  }
}
