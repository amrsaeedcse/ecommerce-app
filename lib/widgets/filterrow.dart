import 'package:ecommerceapp/bloc/filter/filter_control_cubit.dart';
import 'package:ecommerceapp/bloc/filtergender/filter_gender_control_cubit.dart';
import 'package:ecommerceapp/widgets/filterchoice.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'customtext.dart';

class FilterRow extends StatefulWidget {
  const FilterRow({super.key});

  @override
  State<FilterRow> createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  final List<FilterType> sortByList = [
    FilterType.Recommended,
    FilterType.Newest,
    FilterType.Lowest_HighestPrice,
    FilterType.Highest_LowestPrice,
  ];
  late List<Function()> functionsSort;
  late List<Function()> functionsGender;
  final List<FilterGenderType> genderList = [
    FilterGenderType.Men,
    FilterGenderType.Women,
    FilterGenderType.Kids,
  ];

  void showBottomSheet<T extends Cubit<V>, V extends Enum>(
    List<V> data,
    String title,
    List<Function()> functions,
  ) {
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
                    GestureDetector(
                      onTap: () {
                        if (data == sortByList) {
                          context.read<FilterControlCubit>().reset();
                        }
                      },
                      child: CustomText(
                        text: "Clear",
                        weight: FontWeight.w500,
                        size: 16,
                      ),
                    ),
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
                      if (data == sortByList) {
                        return FilterChoice<T, V>(
                          t1: data[index],
                          onTap: functions[index],
                        );
                      } else if (data == genderList) {
                        return FilterChoice<T, V>(
                          t1: data[index],
                          onTap: functions[index],
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
  void initState() {
    // TODO: implement initState
    super.initState();
    functionsSort = [
      () {},
      () {},
      () {
        context.read<FilterControlCubit>().makeLowToHigh();
      },
      () {
        context.read<FilterControlCubit>().makeHighToLow();
      },
    ];
    functionsGender = [
      () {
        context.read<FilterGenderControlCubit>().makeItMen();
      },
      () {
        context.read<FilterGenderControlCubit>().makeItWomen();
        print("happend");
      },
      () {},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 43.w,
          height: 27.h,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/icons/filter.svg"),
              SizedBox(width: 1.5.w),
              CustomText(
                text: "2",
                weight: FontWeight.w700,
                size: 12,
                color: theme.colorScheme.surface,
              ),
            ],
          ),
        ),
        Container(
          width: 59.w,
          height: 27.h,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Center(
            child: CustomText(
              text: "On Sale",
              weight: FontWeight.w700,
              size: 12,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        Container(
          width: 64.w,
          height: 27.h,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Price",
                weight: FontWeight.w700,
                size: 12,
                color: theme.colorScheme.surface,
              ),
              SizedBox(width: 1.5.w),
              SvgPicture.asset("assets/images/icons/arrowdown2.svg"),
            ],
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(100.r),

          onTap: () {
            showBottomSheet<FilterControlCubit, FilterType>(
              sortByList,
              "Sort by",
              functionsSort,
            );
          },
          child: Container(
            width: 78.w,
            height: 27.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Sort by",
                  weight: FontWeight.w700,
                  size: 12,
                  color: theme.colorScheme.primary,
                ),
                SizedBox(width: 1.5.w),
                SvgPicture.asset("assets/images/icons/arrowdown2.svg"),
              ],
            ),
          ),
        ),
        BlocBuilder<FilterGenderControlCubit, FilterGenderType>(
          builder: (context, state) {
            return InkWell(
              onTap: () {
                showBottomSheet<FilterGenderControlCubit, FilterGenderType>(
                  genderList,
                  "Gender",
                  functionsGender,
                );
              },
              borderRadius: BorderRadius.circular(100.r),
              child: Container(
                width: 61.w,
                height: 27.h,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: state.toString().split('.').last,
                      weight: FontWeight.w700,
                      size: 12,
                      color: theme.colorScheme.surface,
                    ),
                    SizedBox(width: 1.5.w),
                    SvgPicture.asset("assets/images/icons/arrowdown2.svg"),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
