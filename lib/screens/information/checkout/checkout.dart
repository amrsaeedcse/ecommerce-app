import 'package:ecommerceapp/bloc/getcartcontrol/get_cart_control_cubit.dart';
import 'package:ecommerceapp/bloc/removeall/remove_all_cubit.dart';
import 'package:ecommerceapp/getx/addresscontrol.dart';
import 'package:ecommerceapp/widgets/CustomElevatedButton.dart';
import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/checkoutinformation.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../getx/pricecontrol.dart';
import '../../../widgets/pricecontainer.dart';
import 'package:get/get.dart';
import 'checkedoutpage.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextEditingController textCont = TextEditingController();
  final priceController = Get.find<PriceControl>();
  final addressController = Get.put(AddressControl());

  @override
  void initState() {
    // TODO: implement initState
    context.read<GetCartControlCubit>().getCart();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<AddressControl>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.only(right: 24.0.w, left: 24.w, bottom: 34.h),
        child: Column(
          children: [
            Gap(63.h),
            Stack(
              alignment: Alignment.center,
              children: [
                Align(alignment: Alignment.centerLeft, child: Back()),
                Center(
                  child: CustomText(
                    text: "Check out",
                    weight: FontWeight.w700,
                    size: 16,
                  ),
                ),
              ],
            ),
            Gap(32.h),
            AddCheckOutInformation(),
            SizedBox(height: 258.h),
            Hero(
              tag: "2",
              child: Obx(
                () => PriceContainer(
                  r1: "\$" + priceController.subTotal.value.toString(),
                  r2: "\$" + priceController.shippingCost.value.toString(),
                  r3: "\$" + priceController.tax.value.toString(),
                  r4: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: "\$" + priceController.total.value.toString(),
                        weight: FontWeight.w700,
                        size: 16.sp,
                        lined: priceController.isDis.value ? true : null,
                      ),
                      priceController.isDis.value
                          ? SizedBox(width: 20.w)
                          : SizedBox.shrink(),
                      priceController.isDis.value
                          ? CustomText(
                              text:
                                  "\$" +
                                  (priceController.total.value -
                                          priceController.disCost.value)
                                      .toString(),
                              weight: FontWeight.w700,
                              size: 16.sp,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(child: Center()),
            SizedBox(
              child: CustomElevatedButton(
                fun: () {
                  if (addressController.addressModel.value == null) {
                    SnackBarWarning.showSnack(
                      "Please Choose address first",
                      context,
                    );
                  } else {
                    context.read<RemoveAllCubit>().deleteAll();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckedOutPage()),
                    );
                  }
                },
                color: theme.primaryColor,
                customText: CustomText(
                  text: "Checkout",
                  weight: FontWeight.w700,
                  size: 16,
                  color: theme.colorScheme.surface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
