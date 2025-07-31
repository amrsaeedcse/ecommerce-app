import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomePageSearch extends StatelessWidget {
  HomePageSearch({this.fn, this.tCont, super.key});
  final TextEditingController? tCont;

  FocusNode? fn;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 40.h,
        child: Stack(
          children: [
            TextFormField(
              focusNode: fn,
              controller: tCont,
              expands: true,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),

                // prefix: Padding(
                //   padding: EdgeInsets.only(right: 12.0.w),
                //   child: SvgPicture.asset(
                //     "assets/images/icons/searchicon.svg",
                //     width: 16.w,
                //     height: 16.h,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                fillColor: Theme.of(context).colorScheme.onPrimary,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 47.w,
                  vertical: 10.h,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.r),
                  borderSide: BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.r),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 19.0.w),
                  child: SvgPicture.asset(
                    "assets/images/icons/searchicon.svg",
                    width: 16.w,
                    height: 16.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
