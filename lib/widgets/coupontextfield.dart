import 'package:ecommerceapp/firebase/firestore/FireBaseFireStore.dart';
import 'package:ecommerceapp/getit/service_locator.dart';
import 'package:ecommerceapp/getx/pricecontrol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CouponTextField extends StatefulWidget {
  const CouponTextField({super.key, required this.textCont});
  final TextEditingController textCont;

  @override
  State<CouponTextField> createState() => _CouponTextFieldState();
}

class _CouponTextFieldState extends State<CouponTextField> {
  final priceController = Get.find<PriceControl>();
  @override
  void initState() {
    // TODO: implement initState
    widget.textCont.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  final FireBaseFireStore fireBaseFireStore = getIt<FireBaseFireStore>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 56.h,
          child: TextFormField(
            controller: widget.textCont,
            expands: true,
            maxLines: null,
            decoration: InputDecoration(
              hintText: "Enter Coupon Code",
              hintStyle: TextStyle(color: theme.colorScheme.surface),
              contentPadding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              prefixIcon: SvgPicture.asset(
                "assets/images/icons/discountshape.svg",
                width: 24.w,
                height: 24.h,
                fit: BoxFit.scaleDown,
              ),
              filled: true,
              fillColor: theme.colorScheme.onPrimary,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Positioned(
          right: 9.w,
          child: FutureBuilder(
            future: fireBaseFireStore.checkCouponCode(
              widget.textCont.text.trim(),
            ),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return CupertinoActivityIndicator(
                  color: Theme.of(context).primaryColor,
                );
              } else if (asyncSnapshot.hasError) {
                return Icon(Icons.error_outline, color: theme.primaryColor);
              }
              bool isHere = asyncSnapshot.data == null ? false : true;
              print(isHere);

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if (mounted) {
                  if (isHere == true) {
                    print(asyncSnapshot.data!.data()!);
                    priceController.isDis.value = true;
                    try {
                      priceController.setDisCost(
                        (asyncSnapshot.data!.data()!['discount'] as num)
                            .toDouble(),
                      );
                    } catch (e) {
                      print("coupon error");
                    }
                  } else {
                    print("dalse");
                    priceController.isDis.value = false;
                  }
                }
              });
              return isHere == true
                  ? Icon(Icons.done, color: theme.primaryColor)
                  : Icon(Icons.close, color: Colors.red);
            },
          ),
        ),
      ],
    );
  }
}
