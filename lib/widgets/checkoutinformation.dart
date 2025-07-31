import 'package:ecommerceapp/animation/fadeanimation.dart';
import 'package:ecommerceapp/widgets/customtext.dart';
import 'package:ecommerceapp/widgets/gap.dart';
import 'package:ecommerceapp/widgets/informationrow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../getx/addresscontrol.dart';
import '../screens/information/address/addresspage.dart';
import 'package:get/get.dart';

class AddCheckOutInformation extends StatelessWidget {
  AddCheckOutInformation({super.key});
  final addressController = Get.find<AddressControl>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeAnimation(
          w: Obx(
            () => InformationRow(
              s2: addressController.addressModel.value == null
                  ? "Shipping Address"
                  : '${addressController.addressModel.value!.street}, ${addressController.addressModel.value!.city}, ${addressController.addressModel.value!.state} ${addressController.addressModel.value!.zipCode}',

              s1: "Add Shipping Address",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressPage()),
                );
              },
            ),
          ),
        ),
        Gap(16.h),
        FadeAnimation(
          w: InformationRow(
            s1: "Payment Method",
            s2: "Add Payment Method",
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
