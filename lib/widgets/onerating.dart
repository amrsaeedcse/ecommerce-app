import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/data/rating/ratingmodel.dart';
import 'package:ecommerceapp/widgets/stars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'customtext.dart';
import 'gap.dart';

class OneRating extends StatelessWidget {
  const OneRating({super.key, required this.rating});
  final RatingModel rating;
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.network(
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                width: 40.w,
                height: 40.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              width: 130.w,
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: rating.userName,
                weight: FontWeight.w700,
                size: 12.sp,
              ),
            ),
            Expanded(child: Center()),
            Stars(rating: rating.rating),
          ],
        ),
        Gap(8.h),
        CustomText(text: rating.comment, weight: FontWeight.w400, size: 12),
        Gap(4.h),
        CustomText(
          text: getTimeDiff(rating.time),
          weight: FontWeight.w400,
          size: 12,
        ),
      ],
    );
  }
}
