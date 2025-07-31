import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../getx/finalratingcont.dart';

class Stars extends StatefulWidget {
  Stars({this.rating = 1, super.key, this.setRating});
  int rating;
  final void Function(int rat)? setRating;
  @override
  State<Stars> createState() => _StarsState();
}

class _StarsState extends State<Stars> {
  final ratingController = Get.put(RatingController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Padding(
          padding: EdgeInsetsGeometry.only(right: 5.0.w),
          child: Material(
            child: InkWell(
              onTap: widget.setRating != null
                  ? () {
                      setState(() {
                        widget.rating = index + 1;
                        ratingController.setNumberOfStar(widget.rating);
                      });
                    }
                  : null,
              child: Icon(
                Icons.star,
                size: 16.sp,
                color: index < widget.rating!
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        );
      }),
    );
  }
}
