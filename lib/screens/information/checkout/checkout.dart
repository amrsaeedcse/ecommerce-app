import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/bloc/addcheckout/add_check_out_cubit.dart';
import 'package:ecommerceapp/bloc/getcartcontrol/get_cart_control_cubit.dart';
import 'package:ecommerceapp/bloc/removeall/remove_all_cubit.dart';
import 'package:ecommerceapp/data/checkout/checkoutmodel.dart';
import 'package:ecommerceapp/getx/addresscontrol.dart';
import 'package:ecommerceapp/widgets/CustomElevatedButton.dart';
import 'package:ecommerceapp/widgets/back.dart';
import 'package:ecommerceapp/widgets/checkoutinformation.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/loading.dart';
import 'package:ecommerceapp/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return BlocListener<AddCheckOutCubit, AddCheckOutState>(
      listener: (context, state) {
        print(state);
        if (state is AddCheckOutFailure) {
          Navigator.pop(context);
          SnackBarWarning.showSnack("error", context);
        } else if (state is AddCheckOutSuccess) {
          Navigator.of(context).pop();
          context.read<RemoveAllCubit>().deleteAll();
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CheckedOutPage()),
          );
        } else if (state is AddCheckOutLoading) {
          Loading.showAlertLoading(context);
        }
      },
      child: Scaffold(
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
                      String address =
                          '${addressController.addressModel.value!.street}, ${addressController.addressModel.value!.city}, ${addressController.addressModel.value!.state} ${addressController.addressModel.value!.zipCode}';

                      context.read<AddCheckOutCubit>().addCheckOut(
                        CheckOutModel(
                          progress: "--",
                          orderId: "--",
                          time: Timestamp.now(),
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          address: address,
                          cartModels:
                              (context.read<GetCartControlCubit>().state
                                      as GetCartControlSuccess)
                                  .cartModels,
                          price:
                              priceController.total.value -
                              (priceController.isDis.value
                                  ? priceController.disCost.value
                                  : 0),
                        ),
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
      ),
    );
  }
}
