import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/notifications/notificationsmodel.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key, required this.data});

  final List<NotificationsModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Container(
          height: 72.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SvgPicture.asset("assets/images/icons/notificationbing.svg"),
                ],
              ),
              SizedBox(width: 29.w),
              SizedBox(
                width: 232.w,
                child: CustomText(
                  text: data[index].message,
                  weight: FontWeight.w700,
                  size: 12.sp,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
      itemCount: data.length,
    );
  }
}
