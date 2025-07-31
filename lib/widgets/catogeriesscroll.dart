import 'package:ecommerceapp/data/catogeries/catogeries.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatogeriesScroll extends StatelessWidget {
  const CatogeriesScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      child: ListView.builder(
        itemCount: CatogeriesModel.catogeriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 13.25.h),
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    CatogeriesModel.catogeriesList[index].image,
                    height: 56.h,
                    width: 56.w,
                  ),
                ),
                Gap(5.h),
                CustomText(
                  text: CatogeriesModel.catogeriesList[index].title,
                  weight: FontWeight.w500,
                  size: 12.sp,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
