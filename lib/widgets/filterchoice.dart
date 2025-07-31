import 'package:color_parser/color_parser.dart';
import 'package:ecommerceapp/bloc/filter/filter_control_cubit.dart';
import 'package:ecommerceapp/getx/finalratingcont.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../bloc/productchoose/product_choose_cubit.dart';

class FilterChoice<T extends Cubit<V>, V> extends StatelessWidget {
  FilterChoice({
    super.key,
    required this.t1,
    required this.onTap,
    this.tapped = false,
  });

  final V t1;
  final void Function() onTap;
  bool tapped;
  String getColorName(Color color) {
    if (color == Colors.red) return 'Red';
    if (color == Colors.green) return 'Green';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.purple) return 'Purple';
    if (color == Colors.black) return 'Black';
    if (color == Colors.white) return 'White';
    if (color == Colors.yellow) return 'Yellow';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.brown) return 'Brown';
    if (color == Colors.grey) return 'Grey';
    return 'Unknown';
  }

  final controller = Get.find<RatingController>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, V>(
      builder: (context, state) {
        if (state is Color) {
          controller.setColor(getColorName(state));
        } else if (state is ProductSize) {
          controller.setSize(state.toString().split('.').last);
        }
        return Container(
          decoration: BoxDecoration(
            color: state == t1
                ? Theme.of(context).primaryColor
                : Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(100.r),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.only(
                top: 18.h,
                bottom: 18.h,
                left: 34.w,
                right: 22.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: t1 is Color
                        ? getColorName(t1 as Color)
                        : t1.toString().split('.').last,
                    weight: FontWeight.w400,
                    size: 16,
                    color: state == t1
                        ? Theme.of(context).colorScheme.surface
                        : null,
                  ),
                  if (state == t1)
                    SvgPicture.asset("assets/images/icons/Frame 36.svg"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
