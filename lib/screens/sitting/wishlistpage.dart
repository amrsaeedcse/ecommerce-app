import 'package:ecommerceapp/bloc/gethomepagecat/get_home_page_cat_cubit.dart';
import 'package:ecommerceapp/bloc/getwishlist/get_wish_list_cubit.dart';
import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/wishlistrow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/gethomepagecat/get_home_page_cat_cubit.dart';
import '../../onetimeadded.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  List<String> categories = ProductModelMake.demo20Products
      .map((e) {
        return e.category;
      })
      .toSet()
      .toList();
  Map<String, List<ProductModel>> productsMap = {};
  @override
  void initState() {
    // TODO: implement initState
    context.read<GetWishListCubit>().getWishList();
    for (var cat in categories) {
      productsMap[cat] = [];
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                    text: "Wishlist",
                    weight: FontWeight.w700,
                    size: 16.sp,
                  ),
                ),
              ],
            ),
            Gap(42.h),
            Expanded(
              child: BlocBuilder<GetWishListCubit, GetWishListState>(
                builder: (context, state) {
                  if (state is GetWishListLoading) {
                    return Center(
                      child: CupertinoActivityIndicator(
                        color: theme.primaryColor,
                      ),
                    );
                  } else if (state is GetWishListFailure) {
                    return Center(
                      child: CustomText(
                        text: "error try again",
                        weight: FontWeight.w700,
                        size: 20.sp,
                      ),
                    );
                  } else if (state is GetWishListEmpty) {
                    return Center(
                      child: CustomText(
                        text: "no WishList try to add",
                        weight: FontWeight.w700,
                        size: 20.sp,
                        color: theme.primaryColor,
                      ),
                    );
                  }
                  final List<ProductModel> data =
                      (state as GetWishListSuccess).productModels;
                  for (var cat in categories) {
                    productsMap[cat] = [];
                  }
                  for (var pr in data) {
                    productsMap[pr.category]?.add(pr);
                  }

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return productsMap[categories[index]]!.isNotEmpty
                          ? WishListRow(
                              productModels: productsMap[categories[index]]!,
                            )
                          : SizedBox.shrink();
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemCount: productsMap.keys.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
