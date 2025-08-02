import 'package:ecommerceapp/bloc/addcartcontrol/add_cart_control_cubit.dart';
import 'package:ecommerceapp/bloc/productchoose/product_choose_color_cubit.dart';
import 'package:ecommerceapp/bloc/productchoose/product_choose_cubit.dart';
import 'package:ecommerceapp/data/cart/cartmodel.dart';
import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/screens/cart/cartpage.dart';
import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/filterchoice.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/heart.dart';
import 'package:ecommerceapp/widgets/productoption.dart';
import 'package:ecommerceapp/widgets/quantitycontrol.dart';
import 'package:ecommerceapp/widgets/ratingsection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../getx/finalratingcont.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Color> colors = [
    Colors.orange,
    Colors.black,
    Colors.red,
    Colors.yellow,
    Colors.blue,
  ];

  List<ProductSize> productSize = [
    ProductSize.S,
    ProductSize.M,
    ProductSize.Xl,
    ProductSize.Xl2,
  ];
  @override
  void initState() {
    // TODO: implement initState
    // print(widget.productModel.id);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (!Get.isRegistered<RatingController>()) {
      Get.delete<RatingController>();
    }
    super.dispose();
  }

  final controller = Get.put(RatingController());

  void showBottomSheet<T extends Cubit<V>, V>(List<V> data, String title) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 390.h,
          padding: EdgeInsets.only(top: 14.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox.shrink(),
                    CustomText(text: title, weight: FontWeight.w700, size: 24),
                    InkWell(
                      customBorder: CircleBorder(),
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset("assets/images/icons/x.svg"),
                    ),
                  ],
                ),
                Gap(28.h),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      if (data == productSize) {
                        return FilterChoice<
                          ProductChooseSizeCubit,
                          ProductSize
                        >(
                          t1: data[index] as ProductSize,
                          onTap: () {
                            context.read<ProductChooseSizeCubit>().putSize(
                              data[index] as ProductSize,
                            );
                          },
                        );
                      } else if (data == colors) {
                        return FilterChoice<ProductChooseColorCubit, Color>(
                          t1: data[index] as Color,
                          onTap: () {
                            context.read<ProductChooseColorCubit>().putColor(
                              data[index] as Color,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 63.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Back(),
                  Heart(productModel: widget.productModel),
                ],
              ),
              Gap(24.h),
              Container(
                height: 248.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Image.network(widget.productModel.imageUrl),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Image.network(widget.productModel.imageUrl),
                    ),
                  ],
                ),
              ),
              Gap(24.h),
              CustomText(
                text: widget.productModel.name,
                weight: FontWeight.w700,
                size: 16.sp,
              ),
              Gap(15.h),
              CustomText(
                text: widget.productModel.price.toString(),
                weight: FontWeight.w700,
                size: 16.sp,
                color: theme.primaryColor,
              ),
              Gap(33.h),
              BlocBuilder<ProductChooseSizeCubit, ProductSize>(
                builder: (context, state) {
                  return ProductOption(
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CustomText(
                          text: state.toString().split('.').last,
                          weight: FontWeight.w700,
                          size: 16,
                        ),

                        SizedBox(width: 25.w),
                        SvgPicture.asset("assets/images/icons/arrowdown2.svg"),
                      ],
                    ),
                    t1: "Size",
                    onTap: () =>
                        showBottomSheet<ProductChooseSizeCubit, ProductSize>(
                          productSize,
                          "Size",
                        ),
                  );
                },
              ),
              Gap(12.h),
              BlocBuilder<ProductChooseColorCubit, Color>(
                builder: (context, state) {
                  return ProductOption(
                    suffix: Row(
                      children: [
                        Container(
                          width: 16.w,
                          height: 16.h,
                          decoration: BoxDecoration(
                            color: state,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 25.w),
                        SvgPicture.asset("assets/images/icons/arrowdown2.svg"),
                      ],
                    ),
                    t1: "Color",
                    onTap: () =>
                        showBottomSheet<ProductChooseColorCubit, Color>(
                          colors,
                          "Color",
                        ),
                  );
                },
              ),
              Gap(12.h),
              ProductOption(suffix: QuantityControl(), t1: "Quantity"),
              Gap(26.h),
              CustomText(
                text:
                    "Built for life and made to last, this full-zip corduroy jacket is part of our Nike Life collection. The spacious fit gives you plenty of room to layer underneath, while the soft corduroy keeps it casual and timeless.",
                weight: FontWeight.w400,
                size: 12.sp,
                color: theme.colorScheme.onPrimary,
              ),
              Gap(24.h),
              CustomText(
                text: "Shipping & Returns",
                weight: FontWeight.w700,
                size: 16.sp,
              ),
              Gap(12.h),
              CustomText(
                text: "Free standard shipping and free 60-day returns",
                weight: FontWeight.w400,
                size: 12.sp,
                color: theme.colorScheme.onPrimary,
              ),
              Gap(24.h),
              RatingSection(productModel: widget.productModel),
              BlocConsumer<AddCartControlCubit, AddCartControlState>(
                listener: (context, state) {
                  if (state is AddCartControlFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: theme.primaryColor,
                        content: Center(
                          child: CustomText(
                            text: "error happened",
                            weight: FontWeight.w700,
                            size: 15,
                            color: theme.colorScheme.surface,
                          ),
                        ),
                      ),
                    );
                  } else if (state is AddCartControlSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: theme.primaryColor,
                        content: Center(
                          child: CustomText(
                            text: "Added to cart Successfully",
                            weight: FontWeight.w700,
                            size: 15,
                            color: theme.colorScheme.surface,
                          ),
                        ),
                      ),
                    );
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => CartPage()));
                  }
                },
                builder: (context, state) {
                  return ProductOption(
                    onTap: state is! AddCartControlLoading
                        ? () {
                            CartModel cartModel = CartModel(
                              name: widget.productModel.name,
                              imageUrl: widget.productModel.imageUrl,
                              size: controller.size.value,
                              color: controller.color.value,
                              price: widget.productModel.price,
                              quantity: controller.quantity.value,
                            );
                            context.read<AddCartControlCubit>().addCart(
                              cartModel,
                            );
                          }
                        : null,
                    color: theme.primaryColor,
                    textColor: theme.colorScheme.surface,
                    suffix: state is! AddCartControlLoading
                        ? CustomText(
                            text: "Add to Bag",
                            weight: FontWeight.w700,
                            size: 16,
                            color: theme.colorScheme.surface,
                          )
                        : CupertinoActivityIndicator(
                            color: theme.colorScheme.surface,
                          ),
                    t1: widget.productModel.price.toString(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
