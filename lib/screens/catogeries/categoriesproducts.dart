import 'package:ecommerceapp/bloc/getcategoriesPr/get_categoreies_pr_cubit.dart';
import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/productsgrid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CategoriesProducts extends StatefulWidget {
  const CategoriesProducts({super.key, required this.productModel});

  final String productModel;

  @override
  State<CategoriesProducts> createState() => _CategoriesProductsState();
}

class _CategoriesProductsState extends State<CategoriesProducts> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getCatPr();
  }

  Future getCatPr() async {
    context.read<GetCategoreiesPrCubit>().getCategoriesPr(widget.productModel);
  }

  List<ProductModel> categoryProducts = [];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: BlocBuilder<GetCategoreiesPrCubit, GetCategoreiesPrState>(
        builder: (context, state) {
          FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();
          categoryProducts = fireBaseFireStore.categoryProduct;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(63.h),
                Back(),
                Gap(16.h),
                CustomText(
                  text:
                      "${widget.productModel}(${state is GetCategoreiesPrLaoding ? '0' : categoryProducts.length})",
                  weight: FontWeight.w700,
                  size: 16.sp,
                ),
                Gap(23.h),
                state is GetCategoreiesPrLaoding
                    ? Expanded(
                        child: Center(
                          child: CupertinoActivityIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : (state is GetCategoreiesPrEmpty
                          ? Expanded(
                              child: Center(
                                child: Lottie.asset(
                                  "assets/lottie/Empty Box - Empty Search.json",
                                ),
                              ),
                            )
                          : Expanded(
                              child: ProductsGrid(
                                count: categoryProducts.length,
                                data: categoryProducts,
                              ),
                            )),
              ],
            ),
          );
        },
      ),
    );
  }
}
