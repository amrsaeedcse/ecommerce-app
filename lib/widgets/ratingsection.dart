import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/bloc/addrating/add_rating_cubit.dart';
import 'package:ecommerceapp/getx/finalratingcont.dart';
import 'package:ecommerceapp/bloc/getratings/get_ratings_cubit.dart';
import 'package:ecommerceapp/data/product/productmodel.dart';
import 'package:ecommerceapp/data/rating/ratingmodel.dart';
import 'package:ecommerceapp/widgets/addratingsection.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/onerating.dart';
import 'package:ecommerceapp/widgets/stars.dart';
import 'package:ecommerceapp/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RatingSection extends StatefulWidget {
  const RatingSection({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<RatingSection> createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  // List<RatingModel> ratings = [];
  TextEditingController tCont = TextEditingController();
  // final ratingController = Get.create(() => RatingController());
  final ratingController1 = Get.find<RatingController>();
  ScrollController controller = ScrollController();

  String getTimeDiff(Timestamp time) {
    final DateTime date = time.toDate();
    final Duration diff = DateTime.now().difference(date);

    final int days = diff.inDays;
    if (days == 1) {
      return '1 day ago';
    } else {
      return '$days days ago';
    }
  }

  int rating = 1;

  void setRating(int rat) {
    rating = rat;
    print(rating);
  }

  double getFinalRating(List<RatingModel> raringModels) {
    int sum = 0;
    for (RatingModel ratingModel in raringModels) {
      sum += ratingModel.rating;
    }
    return sum / raringModels.length;
  }

  void resetList() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (controller.hasClients) {
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 400),
          curve: Curves.bounceIn,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<GetRatingsCubit>().getRating(widget.productModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "Reviews", weight: FontWeight.w700, size: 16),
        Gap(12.h),
        Obx(() {
          print(ratingController1.finalRating.value.toStringAsFixed(1));
          return CustomText(
            text:
                "${ratingController1.finalRating.value.toStringAsFixed(1)} Ratings",
            weight: FontWeight.w700,
            size: 24,
          );
        }),
        Gap(12.h),
        Obx(() {
          print(ratingController1.numberOfThem.value);
          return CustomText(
            text: "${ratingController1.numberOfThem.value} Reviews",
            weight: FontWeight.w400,
            size: 12,
          );
        }),
        Gap(16.h),
        Container(
          height: 260.h,
          child: BlocBuilder<GetRatingsCubit, GetRatingsState>(
            builder: (context, state) {
              if (state is GetRatingsLoading) {
                return Center(child: CupertinoActivityIndicator());
              } else if (state is GetRatingsFailure) {
                return Center(
                  child: Lottie.asset("assets/lottie/Lonely 404.json"),
                );
              } else if (state is GetRatingsEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    SizedBox(
                      height: 170.h,
                      child: Lottie.asset(
                        "assets/lottie/No History.json",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Stars(setRating: setRating),
                    ),
                    AddRatingSection(
                      productModel: widget.productModel,
                      resetList: resetList,
                    ),
                  ],
                );
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (controller.hasClients) {
                  controller.animateTo(
                    controller.position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });
              final List<RatingModel> data =
                  (state as GetRatingsSuccess).ratings;
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if (mounted) {
                  ratingController1.setNumber(data.length);
                  ratingController1.setRating(getFinalRating(data));
                }
              });
              print(data[0].comment);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: controller,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return OneRating(rating: data[index]);
                      },
                    ),
                  ),
                  Gap(10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stars(setRating: (rat) {}),
                      AddRatingSection(
                        productModel: widget.productModel,
                        resetList: resetList,
                      ),
                    ],
                  ),
                  Gap(10.h),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
